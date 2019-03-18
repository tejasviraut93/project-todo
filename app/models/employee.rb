class Employee < ApplicationRecord
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enumerize :role, in: %i[admin developer], default: :developer

  attr_accessor :organization_name, :skip_organization_details

  belongs_to :organization, optional: true
  has_many :employee_projects, dependent: :destroy
  has_many :projects, through: :employee_projects
  has_many :todos, through: :employee_projects

  validates :name,
            presence: true,
            format: {
              with: /\A[^0-9`!@#\$%\^&*+_=]+\z/,
              message: 'is invalid'
            }
  validates :email,
            format: {
              with: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+\z/,
              message: 'is invalid'
            }, uniqueness: true
  validates :organization_name,
            presence: true,
            format: {
              with: /\A[^`!@#\$%\^&*+_=]+\z/,
              message: 'is invalid'
            }, on: :create, unless: :skip_organization_details

  before_create :create_organization

  scope :developers, -> { where(role: 'developer') }
  scope :admin, -> { where(role: 'admin') }

  def admin?
    role == 'admin'
  end

  private

  def create_organization
    self.organization = Organization.create(
      name: organization_name
    ) unless self.organization
  end
end
