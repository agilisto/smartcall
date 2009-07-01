$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'smartcall/soap/default'
require 'smartcall/soap/default_driver'
require 'smartcall/soap/smartcall_error'
require 'smartcall/soap/sms_ws_client'

module Smartcall
  VERSION = '0.0.1'

  class API
    
    def initialize(username, password, campaign_id, reference)
      @client = Smartcall::Soap::SmsWSClient.new(username, password, campaign_id, reference)
    end
    
    def send_message(msisdn, message_body, options = {})
      @client.send_sms(msisdn, message_body)
    end
    
    def send_binary_message(msisdn, header, part, options = {})
      raise NotImplementedError.new
    end

    def send_wap_link(msisdn, href, message, options = {})
      raise NotImplementedError.new
    end
  end
end