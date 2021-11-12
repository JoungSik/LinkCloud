class V1::LinksController < ApplicationController
  before_action :authenticate_v1_user!
  before_action :set_link, only: %i[ show edit update destroy ]

  def index
    @links = current_v1_user.links
  end

  def show
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      render json: @link, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      render json: @link, status: :ok
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find params[:id]
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:name, :url).reverse_merge({ user: current_v1_user })
  end
end
