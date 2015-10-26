class Source < ActiveRecord::Base
  nilify_blanks
  has_and_belongs_to_many :conditions

  scope :ordered, -> { order(:position) }

  def to_s
    I18n.t("source_#{self.code}")
  end
end
