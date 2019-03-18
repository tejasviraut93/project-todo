class Todo < ApplicationRecord
  extend Enumerize
  belongs_to :project
  belongs_to :employee_project, optional: true

  enumerize :status, in: %i[new in_progress done], default: :new
  validates :description,
            presence: true

  scope :new_todos, -> { where(status: 'new') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :done, -> { where(role: 'done') }
end
