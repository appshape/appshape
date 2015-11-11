class TestFormatter
  def initialize(test)
    @test = test
  end

  def as_json
    @test.as_json(only: [:id, :locations],
      include: {
        requests: {
          except: [:name, :description, :created_at, :updated_at]
        }
      }
    )
  end
end