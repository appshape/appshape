class OrganizationPresenter
  attr_reader :organization
  delegate :name, :users, :projects, :organization_users,
           to: :organization

  def initialize(organization_id)
    @organization = Organization.includes(projects: :tests, organization_users: :user).find(organization_id)
  end

  def user_role(user)
    organization_users.select {|ou| ou.user_id == user.id}.first.role
  end

  def organization_users
    @organization_users ||= organization.organization_users
  end

  def projects_test_count(project)
    project.tests.length
  end
end