class Organization < ApplicationRecord
  has_many :equipments
  has_many :clients_organizations
  has_many :clients, through: :clients_organizations

  validates :name, presence: true
  validates :kind, presence: true
  validates :inn, presence: true, numericality: { only_integer: true }
  validates :ogrn, presence: true, numericality: { only_integer: true }
end
