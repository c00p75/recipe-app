Rails.application.routes.draw do
  root 'public_recipes#index'
  
  devise_for :users
  
  resources :users, only: [:index] do
    resources :foods
    resources :recipes
  end
end
