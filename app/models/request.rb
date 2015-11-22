class Request < ActiveRecord::Base
  nilify_blanks

  belongs_to :test, touch: true
end
