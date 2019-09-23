class Staffs::ClientsController < Staffs::BaseController
  def index
    @clients = Client.all
    render json: ClientSerializer.new(@clients)
  end

  def verify_uniqueness
    @client = Client.new(creation_params)
    if @client.valid_uniqueness?
      render json: { data: { message: 'ok' } }
    else
      respond_with_validation_error(@client)
    end
  end

  def create
    client_params = { password: SecureRandom.hex(5) }.merge(creation_params)
    @client = Client.new(client_params)
    if @client.valid?
      @client.save
      render json: ClientSerializer.new(@client), status: :created
    else
      respond_with_validation_error(@client)
    end
  end

  private

  def creation_params
    params.require(:client).permit(:fullname, :phone, :email)
  end
end
