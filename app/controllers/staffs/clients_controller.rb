class Staffs::ClientsController < Staffs::BaseController
  before_action :set_client, only: %i[show update]

  def index
    @clients = Client.all
    render json: ClientSerializer.new(@clients)
  end

  def verify_uniqueness
    @client = Client.new(permitted_params)
    if @client.valid_uniqueness?
      render json: { data: { message: 'ok' } }
    else
      respond_with_validation_error(@client)
    end
  end

  def create
    client_params = { password: SecureRandom.hex(5) }.merge(permitted_params)
    @client = Client.new(client_params)
    if @client.valid?
      @client.save
      render json: ClientSerializer.new(@client), status: :created
    else
      respond_with_validation_error(@client)
    end
  end

  def show
    render json: ClientSerializer.new(@client)
  end

  def update
    if @client.update(permitted_params)
      render json: ClientSerializer.new(@client)
    else
      respond_with_validation_error(@client)
    end
  end

  private

  def permitted_params
    params.require(:client).permit(:fullname, :phone, :email)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
