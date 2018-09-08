Rails.application.routes.draw do
  get 'cities/index'
  get 'states/index'
  devise_for :users
  root to: 'pages#home'
  get 'development', to: 'pages#development'
  resources :types, only: [:index]
  resources :states, only: [:index]
  resources :packings, only: [:index]
  resources :uses, only: [:index]
  resources :categories, only: [:index, :new, :create]
  resources :harmonics, only: [:index, :new, :create]
  resources :products
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
