Rails.application.routes.draw do
  get 'shopping_list', to: 'shopping_list#index'
  root 'public_recipes#index'
  
  devise_for :users
  
  resources :users, only: [:index] do
    resources :foods
    resources :recipes do
      resources :recipe_foods
    end
  end
end
