class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.references :type_equipment, foreign_key: true
      t.string :serial_number, null: false

      t.timestamps
    end
  end
end
