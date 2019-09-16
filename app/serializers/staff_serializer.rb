class StaffSerializer < ApplicationSerializer
  attributes :email, :name

  attribute :name do |object|
    object.email
  end
end
