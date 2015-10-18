class Location < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  def to_s
    I18n.t("location_#{self.code}")
  end
end
