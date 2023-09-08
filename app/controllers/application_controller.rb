class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :lastname, :dni, :phone_number, :speciality_id])
  end
end
