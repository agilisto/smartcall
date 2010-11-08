module Smartcall
  module Soap
    class SmartcallError < StandardError
      def initialize(message)
        super(message)
      end
    end
    class TokenExpiredError < SmartcallError
      def initialize(message)
        super(message)
      end
    end
  end
end