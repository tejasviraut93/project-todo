class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_organization

  private

  def current_organization
    @organization = current_employee.organization if current_employee
  end
end
