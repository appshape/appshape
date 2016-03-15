module ProjectsHelper
  def organization_projects(organization)
    organization.projects.order(name: :asc)
  end
end