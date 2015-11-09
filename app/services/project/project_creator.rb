class Project::ProjectCreator
  def initialize(organization, name)
    @organization = organization
    @name = name
  end

  def execute
    @organization.projects.create(name: @name)
  end
end