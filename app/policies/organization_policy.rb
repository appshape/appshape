class OrganizationPolicy
  attr_reader :user, :organization

  def initialize(user, organization)
    @user = user
    @organization = organization
  end

  def manage?
    organization_user.present? && organization_user.role == 'admin'
  end

  def show?
    OrganizationUser.exists?(user: @user, organization: @organization)
  end

  protected

  def organization_user
    @organization_user ||= organization.organization_users.select do |ou|
      ou.user_id == @user.id
    end.first
  end
end
