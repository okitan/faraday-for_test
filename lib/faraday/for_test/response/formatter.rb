require "rack/utils"

module Faraday::ForTest
  class Configuration
    def body_formatters
      @body_formatters ||= {
        "application/x-www-form-urlencoded" => Rack::Utils.method(:build_query)
      }
    end

    def add_body_formatter(key, proc = nil, &block)
      body_formatters[key] = block_given? ? block : proc
    end
  end

  class Response
    module Formatter
      # TODO: actual http version
      def request_line
        [ env[:method].upcase, env[:url], "HTTP/1.1" ].join(" ") + "\n"
      end

      def request_headers
        env[:request_headers].map {|k, v| "#{k}: #{v}" }.join("\n")
      end

      # TODO: configuraable
      def request_body(pretty = false)
        if request_params && !request_params.empty? && !%i[ get delete ].include?(env[:method])
          if formatter = Faraday::ForTest.configuration.body_formatters.find {|k, v| env[:request_headers]["Content-Type"] =~ /#{k}/ }
            formatter.last.call(request_params)
          else
            request_params.inspect
          end
        else
          ""
        end + "\n"
      end

      # TODO: reason-phase
      def status_line
        [ "HTTP/1.1", status ].join(" ") + "\n"
      end

      def response_headers
        headers.map {|k, v| "#{k}: #{v}" }.join("\n")
      end

      def response_body(pretty = false)
        if body && !body.empty?
          if formatter = Faraday::ForTest.configuration.body_formatters.find {|k, v| headers["content-type"] =~ /#{k}/ }
            formatter.last.call(body)
          else
            body.inspect
          end
        else
          ""
        end + "\n"
      end
    end

    include Formatter
  end
end
