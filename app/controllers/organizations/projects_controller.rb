class Organizations::ProjectsController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
  end

  def show
  end

  def new
    @organization = Organization.find(params[:organization_id])
  end

  def create
  end


end