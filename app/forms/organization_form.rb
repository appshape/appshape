class OrganizationForm < VirtusForm
  attribute :name, String
  validates :name, presence: true
  validate :name_is_unique

  private

  def name_is_unique
    if Organization.exists?(name: name)
      errors.add(:name, 'Organization name is taken')
    end
  end
end