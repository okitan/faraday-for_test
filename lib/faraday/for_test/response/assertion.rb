require "faraday/for_test/response"

class Faraday::ForTest::Response
  module Assertion
    class AssertionError < StandardError
      attr_accessor :response

      def initialize(response)
        @response = response
      end
    end

    def must_succeed
      if response.success?
        raise AssertionError.new(response)
      else
        self
      end
    end
  end

  include Assertion
end
