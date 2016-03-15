module OrganizationsHelper
  def user_organizations(user)
    user.organizations.order(name: :asc)
  end
end