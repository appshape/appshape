class Organization::PersonalOrganizationCreator < Organization::OrganizationCreator
  def execute
    Organization::PersonalOrganization.create(personal_owner: @user, name: @name)
  end
end