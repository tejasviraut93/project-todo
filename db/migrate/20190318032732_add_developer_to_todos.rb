class AddDeveloperToTodos < ActiveRecord::Migration[5.2]
  def change
    add_reference :todos, :employee_project, foreign_key: true
  end
end
