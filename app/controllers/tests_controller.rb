class TestsController < ApplicationController
  def index
    @grouped_tests = Test::Repository.by_user_grouped(current_user)
  end

  def show
    @test = Test.find(params[:id])
  end

  def new
    @form = TestForm.new(new_test_with_request)
    @form.prepopulate!
  end

  def create
    @form = TestForm.new(new_test_with_request)
    if @form.validate(test_permitted_params)
      @form.save
      redirect_to tests_path, notice: 'Your test form has been saved!'
    else
      @form.organization = current_user.organizations.friendly.find(test_permitted_params[:organization])
      render action: :new
    end
  end

  def edit
    @form = TestForm.new(Test.find(params[:id])) #FIXME: bieda security
  end

  def update
    @form = TestForm.new(Test.find(params[:id])) #FIXME: bieda security
    if @form.validate(test_permitted_params)
      @form.save
      redirect_to tests_path, notice: 'Your test has been saved!'
    else
      render :edit
    end
  end

  def toggle
    @test = Test.find(params[:id])
    @test.update_attributes(active: !@test.active)
    redirect_to :back
  end

  def destroy
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to :back
  end

  private
  def test_permitted_params
    rewrite_keys!
    params.require(:test).permit!
  end

  def rewrite_keys!
    params[:test][:request_attributes][:headers]      = params[:test][:request_attributes].delete(:headers_attributes).try(:values) || []
    params[:test][:request_attributes][:url_params]   = params[:test][:request_attributes].delete(:url_params_attributes).try(:values) || []
    params[:test][:request_attributes][:form_params]  = params[:test][:request_attributes].delete(:form_params_attributes).try(:values) || []
    params[:test][:request_attributes][:assertions]   = params[:test][:request_attributes].delete(:assertions_attributes).try(:values) || []
    params[:test][:request_attributes][:data_points]  = params[:test][:request_attributes].delete(:data_points_attributes).try(:values) || []
  end

  def new_test_with_request
    Test.new(locations: []).tap do |test|
      test.organization = user_organization
      test.project = user_project
      test.build_request(headers: [], url_params: [], form_params: [], assertions: [], data_points: [])
    end
  end

  def user_project
    user_organization.projects.friendly.find(params[:project]) if params[:project]
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def user_organization
    current_user.organizations.friendly.find(params[:organization])
  rescue ActiveRecord::RecordNotFound
    current_user.personal_organization
  end
end