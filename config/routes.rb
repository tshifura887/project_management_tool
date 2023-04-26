Rails.application.routes.draw do
  resources :tasks
  devise_for :users
  resources :projects do
    resources :team_assignments, only: [:new, :create, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
end
