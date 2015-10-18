class UserOrganizationsPresenter
  def initialize(user)
    @user = user
  end

  def organizations
    @organizations ||= Organization.order(name: :asc).where('id IN (?)', organization_user_ids)
  end

  def admin?(organization)
    user_role(organization) ==  'admin'
  end

  def user_role(organization)
    organization_users.select { |ou| ou.user_id == @user.id && ou.organization_id == organization.id}.first.role
  end

  private

  def organization_users
    @organization_users ||= OrganizationUser.where(user: @user)
  end

  def organization_user_ids
    organization_users.map(&:organization_id)
  end
end