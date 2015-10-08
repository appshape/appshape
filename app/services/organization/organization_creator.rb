class Organization::OrganizationCreator
  def initialize(user, name)
    @user = user
    @name = name
  end

  def execute
    Organization.create(name: @name)
  end
end