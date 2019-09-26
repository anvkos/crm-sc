class Staffs::IndexController < Staffs::BaseController
  layout 'staffs'

  def index; end

  def user
    render json: StaffSerializer.new(current_user)
  end
end
