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
      unless success?
        raise AssertionError.new(self)
      else
        self
      end
    end
  end

  include Assertion
end
