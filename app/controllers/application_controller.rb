# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_organization, :current_ability

  private

  def current_organization
    @organization = current_employee.organization if current_employee
  end

  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end
end
