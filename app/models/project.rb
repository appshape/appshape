class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :organization

  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :tests, dependent: :destroy

  def slug_candidates
    [
        :name,
        [:name, :organization_id]
    ]
  end
end
