class Todo < ApplicationRecord
  extend Enumerize
  belongs_to :project
  has_many :assigned_todos, dependent: :destroy
  has_many :employees, through: :assigned_todos

  enumerize :status, in: %i[new in_progress done], default: :new
  validates :description,
            presence: true

  scope :new_todos, -> { where(status: 'new') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :done, -> { where(role: 'done') }
end
