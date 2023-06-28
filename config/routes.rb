Rails.application.routes.draw do
  
  devise_for :users
  root 'users#index'
  resources :users, only: [:index] do
    resources :foods
    resources :recipes
  end
end
