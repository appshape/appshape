class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless url?(value) || ip?(value)
      record.errors.add(attribute, :invalid_uri)
    end
  end

  private
  def url?(value)
    uri = URI.parse(value)
    uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

  def ip?(value)
    IPAddress.valid?(value)
  end
end