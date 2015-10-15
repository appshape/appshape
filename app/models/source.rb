class Source < ActiveRecord::Base
  has_and_belongs_to_many :conditions

  scope :ordered, -> { order(:position) }

  def to_s
    I18n.t("source_#{self.code}")
  end
end
