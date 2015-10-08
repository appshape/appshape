class Organization < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true

  def personal_organization?
    self.type == Organization::PersonalOrganization.name
  end
end
