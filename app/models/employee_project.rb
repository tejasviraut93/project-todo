# frozen_string_literal: true

class EmployeeProject < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  has_many :todos, dependent: :nullify

  def name
    employee.name
  end
end

