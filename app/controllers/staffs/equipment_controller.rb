class Staffs::EquipmentController < Staffs::BaseController
  def index
    @equipment_items = Equipment.all
    render json: EquipmentSerializer.new(@equipment_items)
  end
end
