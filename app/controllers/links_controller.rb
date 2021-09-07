class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: [:show, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
    render json: @links.as_json
  end

  # GET /links/1
  def show
    render json: @link.as_json
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
    if @link.update(link_params)
      render json: @link.as_json(:include => { :user => { :only => [:id, :name, :email] } }), status: :ok
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:name, :url, :tag_list).merge({ user: current_user })
  end
end
