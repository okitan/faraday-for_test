require 'delegate'

module Faraday::ForTest
  class Response < SimpleDelegator
    require "faraday/for_test/response/assertion"
    require "faraday/for_test/response/formatter"

    # this overwride assertion
    require "faraday/for_test/response/dumper"

    attr_accessor :request_params

    def initialize(response, params = {})
      @respone = response

      @request_params  = params.delete(:request_params)
      @params  = params

      super(response)
    end
  end
end
