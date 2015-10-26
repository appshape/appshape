class TestPersistenceService
  def initialize(test, attributes)
    @test = test
    @attributes = attributes

    assign_attributes
  end

  def save

  end

  def valid?

  end

  private
  def assign_attributes
    cleanup_empty_rows!(attributes[:request][:headers], [:name, :value])
    cleanup_empty_rows!(attributes[:request][:url_params], [:name, :value])
    cleanup_empty_rows!(attributes[:request][:form_params], [:name, :value])

    @test.attributes = attributes
  end


  def cleanup_empty_rows!(attributes, required_keys = [])
    attributes.reject! { |attribute| attribute.slice(required_keys).all?(&:blank?) }
  end
end