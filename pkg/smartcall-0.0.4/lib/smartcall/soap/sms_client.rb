require "savon"

module Smartcall
  module Soap
    class SmsClient
      
      WSDL = "http://www.smartcalltech.co.za/SmsWS/Service.asmx?wsdl"
      @@token = nil
      
      class << self
        def no_authorisation_error  
          raise SmartcallError.new("SmsWSErrors: Unable to Login")
        end
  
        def invalid_token_error
          raise TokenExpiredError.new("SmsWSErrors: Invalid Token")
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
      end
      
      RESPONSE_HANDLER =    { 'Success' => true , 'InvalidSourceAddress' => Proc.new { SmsClient.invalid_source_address_error } ,
                            'InvalidToken' => Proc.new { SmsClient.invalid_token_error } , 'Failed' => false ,
                            'InvalidNumber' => Proc.new { SmsClient.invalid_number_error }  }
      
      def initialize(username, password, campaign_id, reference)
        @retry = true
        @username, @password, @campaign_id, @reference = username, password, campaign_id, reference
        @client = Savon::Client.new do
          wsdl.document = WSDL
        end
      end
      
      def send_sms(recipient, message_body)
        debugger
        retry_count = 0
        begin
          login unless @@token
          response = @client.request(:send_sms, namespace) do |soap|
            soap.body = {
              :token => @@token,
              :recipient => recipient,
              :message => message_body,
              :reference => @reference,
              :campaignid => @campaign_id
            }
          end.to_hash
          return process_response(RESPONSE_HANDLER[response[:send_sms_response][:send_sms_result]])
        rescue TokenExpiredError => e
          @@token = nil
          retry_count += 1
          retry if retry_count <= 2
          raise e
        end
      end
      
      protected
      def login
        response = @client.request(:login, namespace) do |soap|
          soap.body = {
            :username => @username, 
            :password => @password
          }
        end.to_hash
        unless response[:login_response][:login_result] == true
          raise SmartcallError.new("Login failed")
        end
        @@token = response[:login_response][:token]
      end
      
      def namespace
        {"xmlns" => "http://tempuri.org/"}
      end
      
      def process_response(response_handler)
        response_handler.class == Proc ? response_handler.call : response_handler
      end
    end
  end
end