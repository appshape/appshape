class Source < ActiveRecord::Base
  has_and_belongs_to_many :conditions

  def to_s
    I18.t("source_#{self.code}")
  end
end
