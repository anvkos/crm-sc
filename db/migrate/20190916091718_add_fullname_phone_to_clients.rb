class AddFullnamePhoneToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :fullname, :string, null: false
    add_column :clients, :phone, :bigint, null: false
  end
end
