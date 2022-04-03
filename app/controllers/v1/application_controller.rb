class V1::ApplicationController < ApplicationController
  before_action :authenticate_user!
end
