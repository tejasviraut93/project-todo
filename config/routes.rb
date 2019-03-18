# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :employees do
    resources :todos,
      only: %i[index edit update]
  end

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
  resources :projects do
    resources :employees,
      controller: 'projects/employees',
      only: %i[new create destroy index show]

    resources :todos
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
end
