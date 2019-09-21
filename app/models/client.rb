class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, presence: true, length: { minimum: 5 }
  validates :phone, presence: true, numericality: { only_integer: true }
  validates :phone, uniqueness: true

  def valid_uniqueness?
    valid?
    errors[:email].blank? && errors[:phone].blank?
  end
end
