class Staffs::TypeEquipmentsController < Staffs::BaseController
  def index
    @types = TypeEquipment.all
    render json: TypeEquipmentSerializer.new(@types)
  end
end
