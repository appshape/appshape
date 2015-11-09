class ProjectPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def manage?
    organization_user.role == 'admin'
  end

  def show?
    OrganizationUser.exists?(user: @user, organization: project.organization)
  end

  protected

  def organization_user
    @organization_user ||= OrganizationUser.find_by(user: @user, organization: project.organization)
  end
end
