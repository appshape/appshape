class OrganizationPolicy
  attr_reader :user, :organization

  def initialize(user, organization)
    @user = user
    @organization = organization
  end

  def manage?
    organization_user.role == 'admin'
  end

  def organization_user
    @organization_user ||= OrganizationUser.find_by(user: @user, organization: @organization)
  end
end
