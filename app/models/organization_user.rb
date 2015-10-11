class OrganizationUser < ActiveRecord::Base
  enum role: [:member, :owner]

  belongs_to :user
  belongs_to :organization
end
