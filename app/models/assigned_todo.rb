class AssignedTodo < ApplicationRecord
  belongs_to :employee_project
  belongs_to :todo
end
