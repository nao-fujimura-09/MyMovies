# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :user_state, only: [:create]
    # before_action :customer_state, only: [:create]

  def after_sign_in_path_for(resource)
    public_user_mypage_path(current_user)
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in)
    devise_parameter_sanitizer.permit(:sign_out)
  end

  def user_state
    @user= User.find_by(email: params[:user][:email]) 
    return if !@user
    if @user.valid_password?(params[:user][:password]) && @user.status
       flash[:alert] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_registration_path
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
