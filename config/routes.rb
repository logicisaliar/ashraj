Rails.application.routes.draw do
  get 'brokerage/edit'
  get 'brokerage/index'
  get 'brokerage/show'
  devise_for :users
  root to: 'pages#home'
  get 'development', to: 'pages#development'
  namespace :client do
   resources :orders do
    resources :items, only: [:index, :new, :create]
  end
end
get '/client/order/get_address', to: 'client/orders#get_address'
resources :items, only: [:show, :edit, :update, :destroy]
resources :types, only: [:index]
resources :states, only: [:index]
resources :packings, only: [:index]
resources :uses, only: [:index]
resources :categories, only: [:index, :new, :create]
resources :transports, only: [:index, :new, :create]
resources :pincodes, only: [:index, :new, :create, :edit, :update]
resources :numbers, only: [:index, :new, :create, :edit, :update]
resources :emails, only: [:index, :new, :create, :edit, :update]
resources :cities, only: [:index, :new, :create]
resources :harmonics, only: [:index, :new, :create]
resources :products
resources :addresses, only: [:index,:new, :create, :edit, :update, :show]
resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
