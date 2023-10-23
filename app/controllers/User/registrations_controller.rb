# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    if valid_user_params?
      if params[:user][:password] == params[:user][:password_confirmation]
        super
      else
        redirect_to new_user_registration_path, notice: "Las contraseñas no coinciden"
      end
    else
      redirect_to new_user_registration_path, notice: "Todos los campos son obligatorios"
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_up_params
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :lastname, :dni, :phone_number, :speciality_id])
  #end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


  private

  def valid_user_params?
    params[:user].present? &&
      params[:user][:email].present? &&
      params[:user][:password].present? &&
      params[:user][:name].present? &&
      params[:user][:lastname].present? &&
      params[:user][:dni].present? &&
      params[:user][:phone_number].present? &&
      params[:user][:speciality_id].present?
  end
end