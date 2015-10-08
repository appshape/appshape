class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :identities
  belongs_to :personal_organization, class_name: Organization::PersonalOrganization, foreign_key: :personal_organization_id, dependent: :destroy

  validates :email, presence: true
  validates :name,
            presence: true,
            uniqueness: true

  after_create :create_personal_organization!

  private
  def create_personal_organization!
    Organization::PersonalOrganizationCreator.new(self, self.name).execute
  end
end
