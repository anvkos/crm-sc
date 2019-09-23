class Organization < ApplicationRecord
  validates :name, presence: true
  validates :kind, presence: true
  validates :inn, presence: true, numericality: { only_integer: true }
  validates :ogrn, presence: true, numericality: { only_integer: true }
end
