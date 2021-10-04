class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def render_404
    render json: { message: '해당 항목을 찾을 수 없습니다' }, status: :not_found
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
