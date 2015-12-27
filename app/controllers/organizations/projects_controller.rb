class Organizations::ProjectsController < ApplicationController
  before_action :find_organization

  def index
  end

  def show
    @project = Project.includes(organization: :organization_users).friendly.find(params[:id])
    authorize @project
  end

  def new
    @project = ProjectForm.new(new_project)
    authorize @project, :manage?
  end

  def create
    @project = ProjectForm.new(new_project)
    authorize @project, :manage?
    if @project.validate(project_params)
      created_project = Project::ProjectCreator.new(@organization, @project.name).execute
      redirect_to organization_project_path(@organization, created_project),
                  notice: "Project #{created_project.name} has been created!"
    else
      render action: :new
    end
  end

  private

  def find_organization
    @organization = Organization.includes(:organization_users).friendly.find(params[:organization_id])
  end

  def new_project
    Project.new(organization: @organization)
  end

  def project_params
    params.require(:project).permit!
  end
end