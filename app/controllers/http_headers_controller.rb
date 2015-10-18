class HttpHeadersController < ApplicationController
  respond_to :json

  def index
    respond_with HttpHeader.pluck(:name)
  end
end