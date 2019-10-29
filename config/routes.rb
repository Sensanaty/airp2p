Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :listings do
    resources :rentals, only: [:create]
  end

  resources :rentals, only: [:show] do
    resources :reviews, only: [:create, :edit, :update, :destroy]
  end

  resources :users, only: :show

  get '/dashboard', to: 'dashboard#overview'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Temporary routes to view components, delete later:
  get '/list-items-preview', to: 'pages#list_items_preview'
  get '/reviews_component_preview', to: 'pages#reviews_component_preview'
end
