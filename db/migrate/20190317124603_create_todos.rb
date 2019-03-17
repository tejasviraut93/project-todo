class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.text :description
      t.references :project, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
