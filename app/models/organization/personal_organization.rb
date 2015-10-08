class Organization::PersonalOrganization < Organization
  has_one :personal_owner, class_name: User, foreign_key: :personal_organization_id
  validates :personal_owner, presence: true
end