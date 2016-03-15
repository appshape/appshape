class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :organization_users, dependent: :destroy
  has_many :users, through: :organization_users
  has_many :projects, dependent: :destroy
  has_many :tests, through: :projects
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  def personal_organization?
    self.type == Organization::PersonalOrganization.name
  end

  def creator?(user)
    creator == user
  end
end
