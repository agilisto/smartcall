require 'xsd/qname'

module Smartcall
  module Soap
    # {http://tempuri.org/}login
    class Login
      @@schema_type = "login"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["username", "SOAP::SOAPString"], ["password", "SOAP::SOAPString"]]

      attr_accessor :username
      attr_accessor :password

      def initialize(username = nil, password = nil)
        @username = username
        @password = password
      end
    end

    # {http://tempuri.org/}loginResponse
    class LoginResponse
      @@schema_type = "loginResponse"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["loginResult", "SOAP::SOAPBoolean"], ["token", "SOAP::SOAPString"]]

      attr_accessor :loginResult
      attr_accessor :token

      def initialize(loginResult = nil, token = nil)
        @loginResult = loginResult
        @token = token
      end
    end

    # {http://tempuri.org/}sendSMS
    class SendSMS
      @@schema_type = "sendSMS"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["token", "SOAP::SOAPString"], ["recipient", "SOAP::SOAPString"], ["message", "SOAP::SOAPString"], ["reference", "SOAP::SOAPString"], ["campaignid", "SOAP::SOAPInt"]]

      attr_accessor :token
      attr_accessor :recipient
      attr_accessor :message
      attr_accessor :reference
      attr_accessor :campaignid

      def initialize(token = nil, recipient = nil, message = nil, reference = nil, campaignid = nil)
        @token = token
        @recipient = recipient
        @message = message
        @reference = reference
        @campaignid = campaignid
      end
    end

    # {http://tempuri.org/}sendSMSResponse
    class SendSMSResponse
      @@schema_type = "sendSMSResponse"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["sendSMSResult", "SOAP::SOAPString"]]

      attr_accessor :sendSMSResult

      def initialize(sendSMSResult = nil)
        @sendSMSResult = sendSMSResult
      end
    end

    # {http://tempuri.org/}sendWAPLink
    class SendWAPLink
      @@schema_type = "sendWAPLink"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["token", "SOAP::SOAPString"], ["recipient", "SOAP::SOAPString"], ["href", "SOAP::SOAPString"], ["text", "SOAP::SOAPString"], ["reference", "SOAP::SOAPString"], ["campaignid", "SOAP::SOAPInt"]]

      attr_accessor :token
      attr_accessor :recipient
      attr_accessor :href
      attr_accessor :text
      attr_accessor :reference
      attr_accessor :campaignid

      def initialize(token = nil, recipient = nil, href = nil, text = nil, reference = nil, campaignid = nil)
        @token = token
        @recipient = recipient
        @href = href
        @text = text
        @reference = reference
        @campaignid = campaignid
      end
    end

    # {http://tempuri.org/}sendWAPLinkResponse
    class SendWAPLinkResponse
      @@schema_type = "sendWAPLinkResponse"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["sendWAPLinkResult", "SOAP::SOAPString"]]

      attr_accessor :sendWAPLinkResult

      def initialize(sendWAPLinkResult = nil)
        @sendWAPLinkResult = sendWAPLinkResult
      end
    end

    # {http://tempuri.org/}sendBinaryString
    class SendBinaryString
      @@schema_type = "sendSMS"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["token", "SOAP::SOAPString"], ["recipient", "SOAP::SOAPString"], ["binary", "SOAP::SOAPString"], ["reference", "SOAP::SOAPString"], ["campaignid", "SOAP::SOAPInt"]]
  
      attr_accessor :token
      attr_accessor :recipient
      attr_accessor :binary
      attr_accessor :reference
      attr_accessor :campaignid

      def initialize(token = nil, recipient = nil, binary = nil, reference = nil, campaignid = nil)
        @token = token
        @recipient = recipient
        @binary = binary
        @reference = reference
        @campaignid = campaignid
      end
    end

    # {http://tempuri.org/}sendBinaryStringResponse
    class SendBinaryStringResponse
      @@schema_type = "sendSMSResponse"
      @@schema_ns = "http://tempuri.org/"
      @@schema_qualified = "true"
      @@schema_element = [["sendBinaryStringResult", "SOAP::SOAPString"]]
  
      attr_accessor :sendBinaryStringResult

      def initialize(sendBinaryStringResult = nil)
        @sendBinaryStringResult = sendBinaryStringResult
      end
    end
  end
end