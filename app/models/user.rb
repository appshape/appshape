class User < ActiveRecord::Base
  nilify_blanks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :identities

  has_many :organization_users
  has_many :organizations, through: :organization_users

  has_many :created_organizations, class_name: Organization, foreign_key: :creator_id
  has_one :personal_organization, class_name: Organization::PersonalOrganization, foreign_key: :creator_id, dependent: :destroy


  validates :email, presence: true
  validates :name,
            presence: true,
            uniqueness: true

  before_validation :ensure_name!
  after_create :create_personal_organization!

  private
  def create_personal_organization!
    Organization::PersonalOrganizationCreator.new(self, self.name).execute
  end

  def ensure_name!
    self.name = NameGenerator.new.generate_from_email(self.email) unless self.name.present?
  end
end
