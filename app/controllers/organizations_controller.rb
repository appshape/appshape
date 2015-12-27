class OrganizationsController < ApplicationController
  def index
    @user_organizations_presenter = user_organizations_presenter
  end

  def show
    organization = Organization.includes(projects: :tests, organization_users: :user).friendly.find(params[:id])
    authorize organization
    @organization_presenter = organization_presenter(organization)
  end

  def new
    @organization = OrganizationForm.new(new_organization)
  end

  def create
    @organization = OrganizationForm.new(new_organization)
    if @organization.validate(organizations_params)
      created_organization = Organization::OrganizationCreator.new(current_user, @organization.name).execute
      redirect_to organization_path(created_organization), notice: "Organization #{created_organization.name} has been created!"
    else
      render action: :new
    end
  end

  private

  def new_organization
    Organization.new
  end

  def organizations_params
    params.require(:organization).permit!
  end

  def organization_presenter(organization_id)
    OrganizationPresenter.new(organization_id)
  end

  def user_organizations_presenter
    UserOrganizationsPresenter.new(current_user)
  end
end