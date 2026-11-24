class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    extra_fields = %i[first_name last_name address city postal_code province_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_fields)
    devise_parameter_sanitizer.permit(:account_update, keys: extra_fields)
  end
end
