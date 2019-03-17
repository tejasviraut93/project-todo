# frozen_string_literal: true

Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :employees, controllers: {
    sessions: 'employees/sessions',
    registrations: 'employees/registrations',
    passwords: 'users/passwords'
  }

  authenticated :employee do
    # root 'dashboard#index'
    root to: 'dashboard#index', as: :authenticated_employee_root
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
end
