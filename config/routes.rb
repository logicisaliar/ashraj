Rails.application.routes.draw do
  get 'addresses/new'
  get 'addresses/edit'
  get 'addresses/index'
  get 'addresses/show'
  get 'companies/new'
  get 'companies/edit'
  get 'companies/index'
  get 'companies/show'
  get 'companies/destroy'
  devise_for :users
  root to: 'pages#home'
  get 'development', to: 'pages#development'
  resources :types, only: [:index]
  resources :states, only: [:index]
  resources :packings, only: [:index]
  resources :uses, only: [:index]
  resources :categories, only: [:index, :new, :create]
  resources :pincodes, only: [:index, :new, :create, :edit, :update]
  resources :cities, only: [:index, :new, :create]
  resources :harmonics, only: [:index, :new, :create]
  resources :products
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
