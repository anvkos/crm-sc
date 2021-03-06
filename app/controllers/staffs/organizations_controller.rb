class Staffs::OrganizationsController < Staffs::BaseController
  def index
    @organizations = Organization.all
    render json: OrganizationSerializer.new(@organizations)
  end

  def create
    @organization = Organization.create(organization_params)
    if @organization.persisted?
      render json: OrganizationSerializer.new(@organization), status: :created
    else
      respond_with_validation_error(@organization)
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    head :no_content
  end

  private

  def organization_params
    params.require(:organization).permit(
      :name,
      :kind,
      :inn,
      :ogrn
    )
  end
end
