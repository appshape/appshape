class OrganizationPresenter
  attr_reader :organization
  delegate :name, :users, to: :organization

  def initialize(organization)
    @organization = organization
  end

  def user_role(user)
    organization_users.select {|ou| ou.user_id == user.id}.first.role
  end

  def organization_users
    @organization_users ||= organization.organization_users
  end
end