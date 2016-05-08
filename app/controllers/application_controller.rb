class ApplicationController < ActionController::Base
  include Deviseable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_only!
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'You were redirected from an admin-only page.' if !user_signed_in? || !current_user.admin? }
      format.json { render status: :forbidden if !user_signed_in? || !current_user.admin? }
    end
  end
end
