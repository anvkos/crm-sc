class Staffs::StaffsController < Staffs::BaseController
  before_action :set_staff, only: %i[show update]

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

  def show
    render json: StaffSerializer.new(@staff)
  end

  def update
    if @staff.update(staff_params)
      render json: StaffSerializer.new(@staff)
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

  def set_staff
    @staff = Staff.find(params[:id])
  end
end
