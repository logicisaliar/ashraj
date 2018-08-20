Rails.application.routes.draw do
  get 'packings/index'
  devise_for :users
  root to: 'pages#home'
  resources :types, only: [:index]
  resources :packings, only: [:index]
  resources :uses, only: [:index]
  resources :categories, only: [:index, :new, :create]
  resources :harmonics, only: [:index, :new, :create]
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
