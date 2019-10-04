class CreateTypeEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :type_equipments do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
