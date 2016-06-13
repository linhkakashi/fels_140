Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"
  get "about" => "static_pages#about"

  get    "login"   => "sessions#new"
  post   "login"   => "sessions#create"
  delete "logout"  => "sessions#destroy"

  get "signup" => "users#new"
  resources :users

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories
  end

  resources :relationships, only: [:create, :destroy, :index]
end
