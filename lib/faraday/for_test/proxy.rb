module Faraday
  module ForTest
    class Proxy < BasicObject
      def initialize(client)
        @client = client
      end

      # proxy every method
      def method_missing(name, *args, &block)
        if @client.respond_to?(name)
          maybe_response = @client.__send__(name, *args, &block)

          if maybe_response.is_a?(Faraday::Response)
            response = Faraday::ForTest::Response.new(maybe_response)
            response.request_params = args.find {|e| e.is_a?(Array) || e.is_a?(Hash) || e.is_a?(NilClass) }
            response
          else
            maybe_response
          end
        else
          raise NoMethodError.new("#{name} seems not defined or publid", name)
        end
      end
    end
  end
end
