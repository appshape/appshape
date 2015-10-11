class Organization::PersonalOrganizationCreator < Organization::OrganizationCreator
  def execute
    Organization::PersonalOrganization.create(personal_owner: @user, name: @name).tap do |organization|
      OrganizationUser.create(user: @user, organization: organization, role: :owner)
    end
  end
end