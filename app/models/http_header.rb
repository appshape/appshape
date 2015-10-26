class HttpHeader < ActiveRecord::Base
  nilify_blanks
  validates :name, presence: true, uniqueness: true
end
