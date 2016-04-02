class TestRunGroup < ActiveRecord::Base
  enum result: [:passed, :failed]
  enum status: [:scheduled, :queued, :in_progress, :finished]

  belongs_to :test
  has_many :test_runs, foreign_key: :grouping_code, primary_key: :grouping_code, dependent: :delete_all
end
