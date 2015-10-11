class OrganizationUser < ActiveRecord::Base
  enum role: [:member, :admin]

  belongs_to :user
  belongs_to :organization
end
