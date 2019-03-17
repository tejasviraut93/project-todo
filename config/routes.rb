# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees, controllers: {
    sessions: 'employees/sessions',
    registrations: 'employees/registrations',
    passwords: 'users/passwords'
  }

  authenticated :employee do
    root to: 'dashboard#index', as: :authenticated_employee_root
  end
  get 'dashboard/index'

  resources :developers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
end
