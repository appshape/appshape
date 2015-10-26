class TestForm < Reform::Form
  include Reform::Form::ActiveModel::Validations
  include Populators::TestFormPopulators

  property :name
  property :description
  property :interval
  property :locations

  validates :name, presence: true
  validates :interval, inclusion: { in: proc { Interval.pluck(:code) }}
  validates :locations, length: { minimum: 1 }

  property :request do
    property :http_method
    property :url
    property :basic_auth_user
    property :basic_auth_password

    validates :http_method, presence: true, inclusion: { in: proc { HttpMethod.pluck(:code) }}
    validates :url, presence: true, url: true

    collection :headers, prepopulator: @@headers_prepopulator, populator: @@collection_populator do
      property :name, validates: { presence: true }
      property :value
    end

    collection :url_params, populator: @@collection_populator do
      property :name, validates: { presence: true }
      property :value
    end

    collection :form_params, populator: @@collection_populator do
      property :name, validates: { presence: true }
      property :value
    end

    collection :assertions, prepopulator: @@assertions_prepopulator, populator: @@collection_populator do
      property :source_code
      property :property
      property :condition_code
      property :value

      validates :source_code, presence: true, inclusion: { in: proc { Source.pluck(:code) } }
      validates :property, presence: true, if: proc { |assertion| Source.find_by(code: assertion.source_code).property_required }
      validates :condition_code, presence: true, inclusion: { in: proc { |assertion| Source.find_by(code: assertion.source_code).conditions.map(&:code) }}
      validates :value, presence: true, if: proc { |assertion| Condition.find_by(code: assertion.condition_code).value_required }
    end

    collection :data_points, prepopulator: @@data_points_prepopulator, populator: @@collection_populator do
      property :source_code
      property :property

      validates :source_code, presence: true, inclusion: { in: proc { Source.pluck(:code) } }
    end
  end

  def save
    super do |hash|
      model.request.attributes = hash.delete(:request)
      model.attributes = hash
      model.save
    end
  end
end