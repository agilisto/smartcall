require 'soap/rpc/driver'

module Smartcall
  module Soap

    class SmsWSSoap < ::SOAP::RPC::Driver
      DefaultEndpointUrl = "http://www.smartcalltech.co.za/SmsWS/Service.asmx"
      MappingRegistry = ::SOAP::Mapping::Registry.new

      Methods = [
        [ "http://tempuri.org/login",
          "login",
          [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "login"], true],
            ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "loginResponse"], true] ],
          { :request_style =>  :document, :request_use =>  :literal,
            :response_style => :document, :response_use => :literal }
        ],
        [ "http://tempuri.org/sendSMS",
          "sendSMS",
          [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "sendSMS"], true],
            ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "sendSMSResponse"], true] ],
          { :request_style =>  :document, :request_use =>  :literal,
            :response_style => :document, :response_use => :literal }
        ],
        [ "http://tempuri.org/sendWAPLink",
          "sendWAPLink",
          [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "sendWAPLink"], true],
            ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "sendWAPLinkResponse"], true] ],
          { :request_style =>  :document, :request_use =>  :literal,
            :response_style => :document, :response_use => :literal }
        ],
        [ "http://tempuri.org/sendBinaryString",
          "sendBinaryString",
          [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "sendBinaryString"]],
            ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "sendBinaryStringResponse"]] ],
          { :request_style =>  :document, :request_use =>  :literal,
            :response_style => :document, :response_use => :literal,
            :faults => {} }
        ],
      ]

      def initialize(endpoint_url = nil)
        endpoint_url ||= DefaultEndpointUrl
        super(endpoint_url, nil)
        self.mapping_registry = MappingRegistry
        init_methods
      end

    private

      def init_methods
        Methods.each do |definitions|
          opt = definitions.last
          if opt[:request_style] == :document
            add_document_operation(*definitions)
          else
            add_rpc_operation(*definitions)
            qname = definitions[0]
            name = definitions[2]
            if qname.name != name and qname.name.capitalize == name.capitalize
              ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
                __send__(name, *arg)
              end
            end
          end
        end
      end
    end
  end
end
