class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :allow_parameters, if: :devise_controller?
  include Pagy::Backend
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message, status: :forbidden
  end

  protected

  def allow_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation role])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password role])
  end
end
