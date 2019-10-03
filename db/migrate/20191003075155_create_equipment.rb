class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :kind
      t.string :serial_number

      t.timestamps
    end
  end
end
