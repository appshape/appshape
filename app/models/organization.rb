class Organization < ActiveRecord::Base
  has_many :organization_users
  has_many :users, through: :organization_users

  validates :name,
            presence: true,
            uniqueness: true

  def personal_organization?
    self.type == Organization::PersonalOrganization.name
  end
end
