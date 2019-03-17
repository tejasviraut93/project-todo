class Projects::EmployeesController < ApplicationController
  before_action :authenticate_employee!, :set_project

  def index
    authorize! :index, (@project || @employee)
    @employees = @project.employee_projects
  end

  def show
    authorize! :show, (@project || @employee)
    @employee_project = @project.employee_projects.find(:id)
  end

  def new
    authorize! :new, (@project || @employee)
    @project_employees = @project.employees
    @employees = @organization.employees.developers
      .where.not(id: @project_employees).order(:name)
  end

  def create
    authorize! :create, (@project || @employee)
    @employee = @organization.employees.find(project_employee_params[:employee_id])
    @employee_project = @project.employee_projects.new
    @employee_project.employee = @employee
    respond_to do |format|
      if @employee_project.save
        format.html { redirect_to new_project_employee_path(@project), notice: 'Project was successfully assigned to employee.' }
        format.json { render :show, status: :created, location: @employee_project }
      else
        format.html { render :new }
        format.json { render json: @employee_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, (@project || @employee)
    @employee_project = @project.employee_projects.find(params[:id])
    @employee_project.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'Project was unassigned to employee.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = @organization.projects.find(params[:project_id])
  end

  def project_employee_params
    params.require(:employee_project).permit(
      :employee_id
    )
  end
end
