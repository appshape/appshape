class Test < ActiveRecord::Base
  nilify_blanks
  has_many :requests, dependent: :delete_all
  has_one :request, autosave: true
end
