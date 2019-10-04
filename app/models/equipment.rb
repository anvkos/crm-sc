class Equipment < ApplicationRecord
  belongs_to :type_equipment

  validates :name, presence: true
  validates :serial_number, presence: true
end
