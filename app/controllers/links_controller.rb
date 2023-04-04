class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = Link.includes(:tags)
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
    @link.taggings.build
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path, notice: "링크 생성에 성공 했습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    if @link.update(link_params)
      redirect_to links_path, notice: "링크 수정에 성공 했습니다."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy
    redirect_to links_url, notice: "링크 삭제에 성공 했습니다."
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
