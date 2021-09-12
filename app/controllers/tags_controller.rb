class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = ActsAsTaggableOn::Tag.all
    render json: @tags.as_json({ :except => [:created_at, :updated_at] })
  end

  # GET /tags/1
  def show
    render json: @tag.as_json({ :except => [:created_at, :updated_at] })
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag.as_json({ :except => [:created_at, :updated_at] }), status: :created
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag.as_json({ :except => [:created_at, :updated_at] })
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.fetch(:tag, {})
  end
end
