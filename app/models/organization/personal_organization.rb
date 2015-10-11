class Organization::PersonalOrganization < Organization
  belongs_to :personal_owner, class_name: User, foreign_key: :creator_id
  validates :personal_owner, presence: true
end