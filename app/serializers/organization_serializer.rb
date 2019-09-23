class OrganizationSerializer < ApplicationSerializer
  attributes :id, :name, :kind, :inn, :ogrn, :created_at
end
