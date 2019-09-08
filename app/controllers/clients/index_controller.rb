class Clients::IndexController < ApplicationController
  before_action :authenticate_clients_client!

  def index
  end
end
