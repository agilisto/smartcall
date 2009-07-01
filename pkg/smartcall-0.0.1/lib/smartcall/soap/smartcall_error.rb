module Smartcall
  module Soap
    class SmartcallError < StandardError
      def initialize(message)
        super(message)
      end
    end
  end
end