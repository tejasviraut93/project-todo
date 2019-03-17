class Employee < ApplicationRecord
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enumerize :role, in: %i[admin developer], default: :developer

  attr_accessor :organization_name

  belongs_to :organization, optional: true

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
            }
  validates :organization_name,
            presence: true,
            format: {
              with: /\A[^`!@#\$%\^&*+_=]+\z/,
              message: 'is invalid'
            }, on: :create

  before_create :create_organization

  def create_organization
    self.organization = Organization.create(
      name: organization_name
    )
  end
end
