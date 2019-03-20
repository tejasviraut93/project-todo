class AddFieldsToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :name, :string
    add_column :employees, :role, :string
    add_reference :employees, :organization, foreign_key: true
  end
end
