class HttpMethod < ActiveRecord::Base
  nilify_blanks
  validates :code, presence: true, uniqueness: true

  def to_s
    I18n.t("http_method_#{code}")
  end
end
