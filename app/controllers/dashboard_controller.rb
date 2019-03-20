# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_employee!
  def index
    authorize! :index, Employee
    if current_employee.admin?
      @developers = @organization.employees.includes(:todos).developers.order(:name)

      @projects = @organization.projects.includes(:todos).order(:name)
    end
  end
end
