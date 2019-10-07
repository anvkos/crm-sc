class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clients_organizations
  has_many :organizations, through: :clients_organizations

  validates :fullname, presence: true, length: { minimum: 5 }
  validates :phone, presence: true, numericality: { only_integer: true }
  validates :phone, uniqueness: true

  def valid_uniqueness?
    valid?
    errors[:email].blank? && errors[:phone].blank?
  end
end
