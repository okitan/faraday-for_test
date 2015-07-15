require "faraday/for_test"

require "rack/utils"

require "singleton"

module Faraday
  module ForTest
    class Configuration
      include Singleton

      def body_formatters
        @body_formatters ||= {
          "application/x-www-form-url-encoded" => Rack::Utils.method(:build_query)
        }
      end

      def add_body_formatter(key, proc = nil, &block)
        body_formatters[key] = block_given? ? block : proc
      end
    end
  end
end
