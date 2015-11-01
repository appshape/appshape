class OrganizationPresenter
  attr_reader :organization
  delegate :name, to: :organization

  def initialize(organization)
    @organization = organization
  end
end