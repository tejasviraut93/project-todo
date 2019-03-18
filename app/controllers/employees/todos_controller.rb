class Employees::TodosController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_todo, only: [:edit, :update]

  def index
    if current_employee.admin?
      raise CanCan::AccessDenied.new("Not authorized!", :read, Project)
    else
      @todos = current_employee.todos
      @new = current_employee.todos.new_todos
      @in_progress = current_employee.todos.in_progress
      @done = current_employee.todos.done
    end
  end

  def edit
    if current_employee.admin?
      raise CanCan::AccessDenied.new("Not authorized!", :read, Project)
    end
  end

  def update
    if current_employee.admin?
      raise CanCan::AccessDenied.new("Not authorized!", :read, Project)
    else
      respond_to do |format|
        if @todo.update(developer_todos_params)
          format.html { redirect_to employees_todos_path, notice: 'Todo was successfully updated.' }
          format.json { render :show, status: :ok, location: @todo }
        else
          format.html { render :edit }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
  def set_todo
    @todo = current_employee.todos.find(params[:id])
  end

  def developer_todos_params
    params.require(:todo).permit(
      :status
    )
  end
end

