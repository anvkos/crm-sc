class Staffs::EquipmentController < Staffs::BaseController
  before_action :set_equipment, only: %i[show update]

  def index
    @equipment_items = Equipment.includes(:type_equipment).all
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

  def show
    render json: EquipmentSerializer.new(@equipment)
  end

  def update
    if @equipment.update(equipment_params)
      render json: EquipmentSerializer.new(@equipment)
    else
      respond_with_validation_error(@equipment)
    end
  end

  private

  def equipment_params
    params.require(:equipment).permit(
      :name,
      :type_equipment_id,
      :serial_number,
      :organization_id
    )
  end

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end
end
