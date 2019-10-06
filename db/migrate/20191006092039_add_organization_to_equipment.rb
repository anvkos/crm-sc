class AddOrganizationToEquipment < ActiveRecord::Migration[6.0]
  def change
    add_reference :equipment, :organization, foreign_key: true, index: true
  end
end
