class Condition < ActiveRecord::Base
  nilify_blanks
  has_and_belongs_to_many :sources

  scope :ordered, -> { order(:position) }

  def to_s
    I18n.t("condition_#{self.code}")
  end
end
