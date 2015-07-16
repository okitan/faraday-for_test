require "faraday/for_test/response"

class Faraday::ForTest::Response
  # This is not Logger
  module Dumper
    # TODO: enable configuration
    def dump(pretty = true)
      warn "-------- 8x [req] x8 --------"
      warn request_line
      warn request_headers
      warn "\n"
      warn request_body(pretty)
      warn "-------- 8x [res] x8 --------"
      warn status_line
      warn response_headers
      warn "\n"
      warn response_body(pretty)
      warn "-------- 8x [end] x8 --------"

      self
    end

    def dump_once
      dump unless @dumped
      @dumped = true

      self
    end

    # override assertion
    def must_succeed
      begin
        super
      rescue Faraday::ForTest::Response::Assertion::AssertionError => e
        dump_once
        raise e
      end
    end
  end

  prepend Dumper
end
