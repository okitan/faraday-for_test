module Faraday::ForTest
  class Proxy < BasicObject
    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    # proxy every method
    def method_missing(name, *args, &block)
      if @connection.respond_to?(name)
        maybe_response = @connection.__send__(name, *args, &block)

        if maybe_response.is_a?(::Faraday::Response)
          response = ::Faraday::ForTest::Response.new(maybe_response)

          # TODO: configurable to find out request_params from args
          response.request_params = args.find {|e| e.is_a?(::Array) || e.is_a?(::Hash) || e.is_a?(::NilClass) }
          response
        else
          maybe_response
        end
      else
        super
      end
    end
  end
end
