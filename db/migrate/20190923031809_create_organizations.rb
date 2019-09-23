class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :kind, null: false
      t.bigint :inn
      t.bigint :ogrn

      t.timestamps
    end
  end
end
