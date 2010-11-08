$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'smartcall/soap/sms_client'
require 'smartcall/soap/smartcall_error'

VERSION = '0.0.3'

module Smartcall

  class API
    
    def initialize(username, password, campaign_id, reference)
      @client = Smartcall::Soap::SmsClient.new(username, password, campaign_id, reference)
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