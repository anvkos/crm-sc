class EquipmentSerializer < ApplicationSerializer
  attributes :id, :name, :type_equipment_id, :serial_number, :organization_id

  attribute :type_equipment_name do |object|
    object.type_equipment.name
  end
end
