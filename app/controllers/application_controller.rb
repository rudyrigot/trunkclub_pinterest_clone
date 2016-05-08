class ApplicationController < ActionController::Base
  include Deviseable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO should be tested too
  before_action :authenticate_user!
end
