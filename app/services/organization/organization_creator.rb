class Organization::OrganizationCreator
  def initialize(user, name)
    @user = user
    @name = name
  end

  def execute
    Organization.create(name: @name, creator: @user).tap { |organization| add_admin(organization) }
  end

  protected

  def add_admin(organization)
    OrganizationUser.create(user: @user, organization: organization, role: :admin)
  end
end