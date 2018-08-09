Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :categories, only: [:index, :new, :create]
  resources :harmonic_details, only: [:index, :new, :create]
  resources :harmonics, only: [:index, :new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
