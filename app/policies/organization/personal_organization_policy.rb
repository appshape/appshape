class Organization::PersonalOrganizationPolicy < OrganizationPolicy
  def manage?
    @organization.personal_owner == @user || organization_user.role == 'admin'
  end
end
