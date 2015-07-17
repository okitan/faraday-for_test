require "faraday/for_test/response"

class Faraday::ForTest::Response
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
      if request_params && !request_params.empty?
        if formatter = Faraday::ForTest.configuration.body_formatters.find {|k, v| env[:request_headers]["Content-Type"] =~ /#{k}/ }
          formatter.last.call(request_params)
        else
          request_params
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

    def response_body(prettyr = false)
      if body && !body.empty?
        if formatter = Faraday::ForTest.configuration.body_formatters.find {|k, v| headers["content-type"] =~ /#{k}/ }
          formatter.last.call(body)
        else
          body
        end
      else
        ""
      end + "\n"
    end
  end
  
  include Formatter
end
