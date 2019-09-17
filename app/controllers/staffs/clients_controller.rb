class Staffs::ClientsController < ApplicationController
  before_action :authenticate_staffs_staff!

  def index
    @clients = Client.all;
    render json: ClientSerializer.new(@clients)
  end

  def create
    params = { password: SecureRandom.hex(5) }.merge(client_params)
    @client = Client.new(params)
    if @client.valid?
      @client.save
      render json: ClientSerializer.new(@client)
    else
      respond_with_validation_error(@client)
    end
  end

  private

  def client_params
    params.permit(:fullname, :phone, :email)
  end

  def respond_with_validation_error(model, errors = nil)
    render_error :unprocessable_entity,
                 message: "Validation failed",
                 errors: (errors || model.errors)
  end

  def render_error(status, resource = nil)
    render status: status,
           json: (resource || { message: "error" })
  end
end
