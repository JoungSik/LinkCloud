# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  wrap_parameters :user, format: [:url_encoded_form, :multipart_form, :json]
  respond_to :json
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

  private

  def respond_with(resource, _opts = {})
    render json: resource.as_json(except: [:jti]), status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "로그아웃 되었습니다." }, status: :ok
  end

  def log_out_failure
    render json: { message: "로그아웃에 실패했습니다." }, status: :unauthorized
  end
end
