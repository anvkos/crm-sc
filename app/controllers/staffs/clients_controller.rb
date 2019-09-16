class Staffs::ClientsController < ApplicationController
  before_action :authenticate_staffs_staff!

  def index
    @clients = Client.all;
    render json: ClientSerializer.new(@clients)
  end
end
