class Organization::OrganizationCreator
  def initialize(user, name)
    @user = user
    @name = name
  end

  def execute
    Organization.create(name: @name).tap do |organization|
      OrganizationUser.create(user: @user, organization: organization, role: :owner)
    end
  end
end