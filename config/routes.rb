FlyfreeMe::Application.routes.draw do
  root 'pages#index'
  get 'about', to: "pages#about"
  get 'contact', to: "pages#contact"
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get 'sign_out', to: "sessions#destroy"
  get 'people', to: "relationships#index"

  # Password Reset Routes

  get 'forgot_password', to: "forgot_passwords#new"
  get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
  resources :forgot_passwords, only: [:create]
  get 'expired_token', to: 'password_resets#expired_token'
  resources :password_resets, only: [:show, :create]

  # Videos and Nested Reviews

  resources :videos do
    resources :votes, only: [:create]
  	resources :reviews, only: [:create]
  end
  get 'featured', to: "videos#featured"

  # Users, Sessions, and Relationships

  resources :users, except: [:destroy]
  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:create, :destroy]
  
  # Admin

  namespace :admin do
    resources :videos, only: [:index, :destroy]
    resources :users, only: [:index]
    post 'feature/:id', to: "videos#feature"
  end

end
