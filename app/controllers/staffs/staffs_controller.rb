class Staffs::StaffsController < Staffs::BaseController
  def index
    @staffs = Staff.all
    render json: StaffSerializer.new(@staffs)
  end
end
