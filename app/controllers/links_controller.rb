class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = Link.includes(:tags).where(user_id: current_user.id)
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
    @link.taggings.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path, notice: t('.notice')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    if @link.update(link_params)
      redirect_to links_path, notice: t('.notice')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy
    redirect_to links_url, notice: t('.notice')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:name, :url, :description, taggings_attributes: [:id, :tag_id, :_destroy])
          .merge(user: current_user)
  end
end
