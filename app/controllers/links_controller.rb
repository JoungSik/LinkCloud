class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: [:show, :update, :destroy]

  # GET /links
  def index
    @links = current_user.links
    render json: @links.as_json
  end

  # GET /links/1
  def show
    if @link.nil?
      render json: @link, status: :not_found
    else
      render json: @link.as_json
    end

  end

  # POST /links
  def create
    @link = Link.new(link_params)
    if @link.save
      render json: @link.as_json(:include => { :user => { :only => [:id, :name, :email] } }), status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.nil?
      render json: @link, status: :not_found
    elsif @link.update(link_params)
      render json: @link.as_json(:include => { :user => { :only => [:id, :name, :email] } }), status: :ok
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /links/1
  def destroy
    if @link.nil?
      render json: @link, status: :not_found
    else
      @link.destroy
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find_by_id params[:id]
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:name, :url, :tag_list).merge({ user: current_user })
  end
end
