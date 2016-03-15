class Test < ActiveRecord::Base
  nilify_blanks

  has_many :requests, dependent: :delete_all
  has_one :request, autosave: true
  belongs_to :project
  has_one :organization, through: :project

  after_touch :cache!

  def cache_key
    "test-#{self.id}"
  end

  private
  def cache!
    Rails.cache.write(cache_key, TestFormatter.new(self).as_json)
  end
end
