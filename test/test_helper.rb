ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Useful for Devise
  def sign_in_as(user_symbol)
		@request.env["devise.mapping"] = Devise.mappings[user_symbol]
		user = users(user_symbol)
		sign_in user
  end

  def sign_out_if_logged_in
    sign_out @controller.current_user if @controller.user_signed_in?
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
