class CreateAssignedTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :assigned_todos do |t|
      t.references :employee_project, foreign_key: true
      t.references :todo, foreign_key: true

      t.timestamps
    end
    add_index :employee_projects_todos, %i[employee_project_id todo_id], unique: true
  end
end
