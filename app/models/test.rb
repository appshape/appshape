class Test < ActiveRecord::Base
  nilify_blanks
  has_many :requests
  has_one :request, autosave: true
end
