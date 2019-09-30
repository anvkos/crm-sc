class Staffs::StaffsController < Staffs::BaseController
  def index
    @staffs = Staff.all
    render json: StaffSerializer.new(@staffs)
  end

  def create
    @staff = Staff.create(staff_params)
    if @staff.persisted?
      render json: StaffSerializer.new(@staff), status: :created
    else
      respond_with_validation_error(@staff)
    end
  end

  private

  def staff_params
    params.require(:staff).permit(
      :fullname,
      :email,
      :password
    )
  end
end
