class Staffs::ClientsOrganizationsController < Staffs::BaseController
  def add_client
    @organization = Organization.find(params[:id])
    @client = Client.find(organization_params[:client_id])
    @organization.clients << @client
    render json: @organization
  end

  private

  def organization_params
    params.require(:organization).permit(:client_id)
  end
end
