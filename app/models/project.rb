class Project < ActiveRecord::Base
  has_many :project_users
  has_many :users, through: :project_users

  validates :name, presence: true
end
