class Request < ActiveRecord::Base
  nilify_blanks

  belongs_to :test

  def headers
    (attributes['headers'] || []).map { |header| OpenStruct.new(header) }
  end

  def url_params
    (attributes['url_params'] || []).map { |param| OpenStruct.new(param) }
  end

  def form_params
    (attributes['form_params'] || []).map { |param| OpenStruct.new(param) }
  end

  def assertions
    (attributes['assertions'] || []).map { |assertion| OpenStruct.new(assertion) }
  end

  def data_points
    (attributes['data_points'] || []).map { |data_point| OpenStruct.new(data_point) }
  end
end
