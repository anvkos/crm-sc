class StaffSerializer < ApplicationSerializer
  attributes :email, :name

  attribute :name, &:email
end
