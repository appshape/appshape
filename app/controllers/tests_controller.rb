class TestsController < ApplicationController
  def new
    @form = TestForm.new(new_test_with_request)
    @form.prepopulate!
  end

  def create
    @form = TestForm.new(new_test_with_request)
    if @form.validate(test_permitted_params)
      @form.save
      redirect_to root_path, notice: 'Your test form has been saved!'
    else
      render action: :new
    end
  end

  def edit
    @form = TestForm.new(Test.find(params[:id]))
  end

  def update
    @form = TestForm.new(Test.find(params[:id]))
    if @form.validate(test_permitted_params)
      @form.save
      redirect_to root_path, notice: 'Your test has been saved!'
    else
      render :edit
    end
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
      test.build_request(headers: [], url_params: [], form_params: [], assertions: [], data_points: [])
    end
  end
end