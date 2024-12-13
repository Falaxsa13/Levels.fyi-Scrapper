Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :companies do
    resources :roles, only: [:index, :create] # Nested routes for roles under companies
  end

  # Roles and nested routes
  resources :roles, only: [:show, :update, :destroy] do
    resources :offers, only: [:index, :create] # Nested routes for offers under roles
  end

  # Offers and nested routes
  resources :offers, only: [:show, :update, :destroy] do
    resource :compensation, only: [:show, :create, :update, :destroy] # Nested compensation
  end

  # Vesting schedules nested under compensation
  resources :compensations, only: [] do
    resources :vesting_schedules, only: [:index, :create]
  end

  # Direct routes for vesting schedules (if needed)
  resources :vesting_schedules, only: [:show, :update, :destroy]
end
