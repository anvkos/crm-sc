class Staffs::EquipmentController < Staffs::BaseController
  def index
    @equipment_items = Equipment.all
    render json: EquipmentSerializer.new(@equipment_items)
  end

  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      render json: EquipmentSerializer.new(@equipment), status: :created
    else
      respond_with_validation_error(@equipment)
    end
  end

  private

  def equipment_params
    params.require(:equipment).permit(
      :name,
      :kind,
      :serial_number
    )
  end
end
