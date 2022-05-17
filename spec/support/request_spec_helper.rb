# frozen_string_literal: true

module Support
  module RequestSpecHelper
    include Warden::Test::Helpers

    def self.included(base)
      base.before(:each) { Warden.test_mode! }
      base.after(:each) { Warden.test_reset! }
    end

    def json_response
      JSON.parse(response.body)
    end
  end
end
