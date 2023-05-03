Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    resources :team_assignments, only: [:new, :create, :destroy]
    resources :tasks do
      delete 'attachments/:id', to: 'tasks#destroy_attachment', as: 'attachment'
      resources :comments
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
end
