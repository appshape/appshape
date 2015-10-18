class OrganizationsController < ApplicationController
  def index
    @user_organizations_presenter = user_organizations_presenter
  end

  def new
    @organization = OrganizationForm.new
  end

  def create
    @organization = OrganizationForm.new(params[:organization_form])
    if @organization.valid?
      Organization::OrganizationCreator.new(current_user, @organization.name).execute
      redirect_to organizations_path
    else
      render :new
    end
  end

  private

  def user_organizations_presenter
    UserOrganizationsPresenter.new(current_user)
  end
end