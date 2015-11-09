class ProjectForm < Reform::Form
  include Reform::Form::ActiveModel::Validations

  property :name
  property :organization

  validates :name, presence: true
  validates :organization, presence: true
  validate :name_is_unique

  private

  def name_is_unique
    if organization.projects.exists?(name: name)
      errors.add(:name, 'Project name is taken')
    end
  end
end