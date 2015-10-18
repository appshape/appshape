class Organization < ActiveRecord::Base
  has_many :organization_users
  has_many :users, through: :organization_users
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  def personal_organization?
    self.type == Organization::PersonalOrganization.name
  end

  def creator?(user)
    creator == user
  end
end
