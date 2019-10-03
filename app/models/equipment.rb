class Equipment < ApplicationRecord
  validates :name, presence: true
  validates :kind, presence: true
  validates :serial_number, presence: true
end
