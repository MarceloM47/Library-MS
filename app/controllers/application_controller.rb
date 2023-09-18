class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :lastname, :dni, :phone_number, :speciality_id])
  end

  before_action :authenticate_user!

  def index
    @user = current_user

    if @user.admin?
      render "admin_index"
    else
      render "user_index"
    end
  end

  def admin_index
    @user = current_user
    
    if @user.admin? != true
      redirect_to root_path
    end
  end

  def user_index
  end
end
