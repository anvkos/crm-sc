class AddFullnameToStaffs < ActiveRecord::Migration[6.0]
  def change
    add_column :staffs, :fullname, :string, null: true
  end
end
