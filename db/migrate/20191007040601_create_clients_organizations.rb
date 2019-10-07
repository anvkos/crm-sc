class CreateClientsOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :clients_organizations do |t|
      t.references :client, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true
    end
  end
end
