class Staffs::OrganizationsController < ApplicationController
  before_action :authenticate_staffs_staff!

  def index
    @organizations = Organization.all
    render json: OrganizationSerializer.new(@organizations)
  end
end
