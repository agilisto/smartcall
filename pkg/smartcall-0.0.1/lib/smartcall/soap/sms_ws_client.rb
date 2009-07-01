module Smartcall
  module Soap
    class SmsWSClient
  
      class << self
        def no_authorisation_error  
          raise SmartcallError.new("SmsWSErrors: Unable to Login")
        end
  
        def invalid_token_error
          raise SmartcallError.new("SmsWSErrors: Invalid Token")
        end
    
        def invalid_source_address_error
          raise SmartcallError.new("SmsWSErrors: Invalid Source Address")
        end
    
        def invalid_number_error
          raise SmartcallError.new("SmsWSErrors: InvalidNumber")
        end
    
        def not_implemented_error
          raise SmartcallError.new("SmsWSErrors: Not Implemented")
        end
        
        def debug_mode=(value)
          @@debug_mode = value
        end
      end
  
      @@debug_mode = false
      
      RESPONSE_HANDLER =    { 'Success' => true , 'InvalidSourceAddress' => Proc.new { SmsWSClient.invalid_source_address_error } ,
                            'InvalidToken' => Proc.new { SmsWSClient.invalid_token_error } , 'Failed' => false ,
                            'InvalidNumber' => Proc.new { SmsWSClient.invalid_number_error }  } 
                            
      DEFAULT_ENDPOINT = "http://www.smartcalltech.co.za/SmsWS/Service.asmx"

      def initialize(username, password, campaign_id, reference)
        @retry = true
        @username, @password, @campaign_id, @reference = username, password, campaign_id, reference
        @obj = SmsWSSoap.new(DEFAULT_ENDPOINT)
        @obj.wiredump_dev = STDERR if @@debug_mode
      end

      def send_sms(cell , msg)
        @cell = cell
        @msg = msg
        @token ||= self.login
        if @token
          s = SendSMS.new(@token , cell , msg , @reference , @campaign_id)
          response = @obj.sendSMS(s)
          return process_response(RESPONSE_HANDLER[response.sendSMSResult])  
        else
          update_token
        end
      end
  
      def send_binary_sms(cell, header, part)
        @cell = cell
        @token ||= self.login
        if @token
          s = SendBinaryString.new(@token, cell, header + part, @reference, @campaign_id)
          response = @obj.sendBinaryString(s)
          result = process_response(RESPONSE_HANDLER[response.sendBinaryStringResult])
          return result
        else
          update_token
        end
      end
  
      def send_wap_link(cell, href, msg)
        @cell = cell
        @msg = msg
        @token ||= self.login
        if @token
          s = SendWAPLink.new(@token , cell , href, msg , @reference , @campaign_id)
          response = @obj.sendWAPLink(s)
          return process_response(RESPONSE_HANDLER[response.sendWAPLinkResult])  
        else
          update_token
        end
      end
  
      protected
  
      def process_response(response_handler)
        response_handler.class == Proc ? response_handler.call : response_handler
      end
  
      def update_token
        @retry ? @token = self.login : ( raise no_authorisation_error )
        @retry = false
      end
  
      def retry_sms
        send_sms(@cell , @msg) if @retry
        @retry = false
      end
  
      def login
        l = Login.new(@username , @password)      
        response = @obj.login(l)
        response.loginResult != 'false' ? @token = response.token : false
      end
    end
  end
end