require 'optparse'
require 'ostruct'

module Smartcall
  module Utility
    class Options #:nodoc:
      class << self
        
        def parse(args)
          @options = self.default_options
          parser = OptionParser.new do |opts|
            opts.banner = "Usage: smartcall [options] recipient message"
            opts.separator ""
            opts.separator "Specific options:"
            
            opts.on('-u', '--username USERNAME',
              "Specify the smartcall username (overrides ~/.smartcall setting)") do |username|
               @options.username = username 
            end
          
            opts.on('-p', '--password PASSWORD',
              "Specify the smartcall password (overrides ~/.smartcall setting)") do |password|
               @options.password = password
            end
          
            opts.on('-c', '--campaign CAMPAIGN_ID',
              "Specify the campaign key (overrides ~/.smartcall setting)") do |key|
               @options.campaign_id = key
            end
            
            opts.on('-r', '--reference REFERENCE',
              "Specify the reference (overrides ~/.smartcall setting)") do |reference|
               @options.reference = reference
            end
                      
            opts.on('-d', '--debug') do
               Smartcall::Soap::SmsWSClient.debug_mode = true
            end
          
            opts.on_tail('-h', '--help', "Show this message") do
              puts opts
              exit
            end
          
            opts.on_tail('-v', '--version') do
              puts "Ruby Smartcall SMS Utility #{Smartcall::VERSION}"
              exit
            end
          end
        
          parser.parse!(args)
          @options.recipient = ARGV[-2]
          @options.message   = ARGV[-1]
        
          if (@options.message.nil? || @options.recipient.nil?) && send_message?
            puts "You must specify a recipient and message!"
            puts parser
            exit
          end

          return @options
        
        rescue OptionParser::MissingArgument => e
          switch_given = e.message.split(':').last.strip
          puts "The #{switch_given} option requires an argument."
          puts parser
          exit
        end
      
        def default_options
          options = OpenStruct.new
          config_file = File.open(File.join(ENV['HOME'], '.smartcall'))
          config = YAML.load(config_file)
          options.username = config['username']
          options.password = config['password']
          options.campaign_id  = config['campaign_id']
          options.reference = config['reference']
          return options
        rescue Errno::ENOENT
          return options
        end
        
        def send_message?
          (@options.show_status.nil? &&
           @options.show_balance.nil?)
        end
        
      end
    end
  end
end
