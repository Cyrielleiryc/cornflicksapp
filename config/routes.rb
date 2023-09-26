Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :groups, only: %i[index show new create]
  resources :groups, only: %i[new create]
  resources :subscriptions, only: %i[index show create destroy]
end
