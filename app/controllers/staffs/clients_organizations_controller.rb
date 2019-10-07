class Staffs::ClientsOrganizationsController < Staffs::BaseController
  def add_client
    @organization = Organization.find(params[:id])
    @client = Client.find(organization_params[:client_id])
    @organization.clients << @client
    render json: @organization
  end

  def add_organization
    @client = Client.find(params[:id])
    @organization = Organization.find(client_params[:organization_id])
    @client.organizations << @organization
    render json: @client
  end

  private

  def organization_params
    params.require(:organization).permit(:client_id)
  end

  def client_params
    params.require(:client).permit(:organization_id)
  end
end
