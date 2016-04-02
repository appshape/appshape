class Test < ActiveRecord::Base
  nilify_blanks

  has_many :requests, dependent: :delete_all
  has_one :request, autosave: true
  belongs_to :project
  has_one :organization, through: :project
  has_many :test_run_groups, dependent: :destroy

  after_save :cache!
  before_destroy :delete_cache!

  def cache_key
    "test-#{self.id}"
  end

  private
  def cache!
    Rails.cache.write(cache_key, TestFormatter.new(self).as_json)
  end

  def delete_cache!
    Rails.cache.delete(cache_key)
  end
end
