Rails.application.routes.draw do
  root 'users#index'
  
  devise_for :users
  
  resources :users, only: [:index] do
    resources :foods
    resources :public_recipes
    resources :recipes do
      resources :recipe_foods
    end
  end
end
