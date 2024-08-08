class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :allow_parameters, if: :devise_controller?
  protected
  def allow_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :role])
  end
end
