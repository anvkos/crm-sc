class Equipment < ApplicationRecord
  belongs_to :type_equipment
  belongs_to :organization

  validates :name, presence: true
  validates :serial_number, presence: true
end
