Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'results', to: 'pages#results'
  get 'movie/:id', to: 'pages#show_movie', as: :movie
  get 'tv/:id', to: 'pages#show_tv', as: :tv
  resources :groups, only: %i[index show new create]
  resources :subscriptions, only: %i[create destroy]
  resources :recommendations, only: %i[create destroy]
end
