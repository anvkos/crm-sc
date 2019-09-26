class Clients::IndexController < ApplicationController
  before_action :authenticate_client!

  def index; end
end
