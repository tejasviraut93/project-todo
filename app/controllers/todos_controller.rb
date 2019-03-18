class TodosController < ApplicationController
  before_action :authenticate_employee!, :set_project
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    authorize! :index, Todo
    @todos = @project.todos
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    authorize! :show, Todo
  end

  # GET /todos/new
  def new
    authorize! :new, Todo
    @todo = @project.todos.new
    @employee_projects = @project.employee_projects
  end

  # GET /todos/1/edit
  def edit
    authorize! :edit, Todo
    @employee_projects = @project.employee_projects
  end

  # POST /todos
  # POST /todos.json
  def create
    authorize! :create, Todo
    @todo = @project.todos.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to project_todo_url(@project, @todo), notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        @employee_projects = @project.employee_projects
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    authorize! :update, Todo
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to project_todo_url(@project, @todo), notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        @employee_projects = @project.employee_projects
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    authorize! :destroy, Todo
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = @organization.projects.find(params[:project_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = @project.todos.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_params
    params.require(:todo).permit(:description, :status, :employee_project_id)
  end
end
