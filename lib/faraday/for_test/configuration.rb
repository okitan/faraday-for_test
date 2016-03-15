require "faraday/for_test"

require "singleton"

# actuall configuration is defined in each class
module Faraday
  module ForTest
    class Configuration
      include Singleton
    end
  end
end
