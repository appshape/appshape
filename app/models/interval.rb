class Interval < ActiveRecord::Base
  nilify_blanks
  def to_s
    I18n.t("interval_#{code}")
  end
end
