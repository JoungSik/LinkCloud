class V1::TagsController < ApplicationController
  before_action :authenticate_v1_user!

  def index
    @tags = Gutentag::Tag.all
  end
end
