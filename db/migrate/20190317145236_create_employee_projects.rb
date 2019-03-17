class CreateEmployeeProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_projects do |t|
      t.references :project, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
    add_index :employee_projects, %i[employee_id project_id], unique: true
  end
end
