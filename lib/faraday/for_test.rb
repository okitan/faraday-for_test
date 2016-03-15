require "faraday"

module Faraday
  module ForTest
    require "faraday/for_test/configuration"

    require "faraday/for_test/proxy"
    require "faraday/for_test/response"

    class << self
      def configuration
        Configuration.instance
      end
      def configure(&block)
        yield(configuration)
      end
    end
  end
end
