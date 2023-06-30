require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :routing do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Cook', email: 'cook1@masterchef.com', password: '123456', confirmed_at: Time.now) }
  let(:recipe) { Recipe.create(user: user, name: 'recipe 1', description: 'description', public: true) }
  let(:food) { Food.create(name: 'pasta', measurement_unit: 'grams', price: 20, quantity: 2, user: user) }
  let(:recipe_food) { RecipeFood.create(food_id: food.id, recipe_id: recipe.id, quantity: 1) }

  describe 'routing' do
    before do
      sign_in user
    end

    it 'routes to #new' do
      expect(get: "/users/#{user.id}/recipes/#{recipe.id}/recipe_foods/new").to route_to('recipe_foods#new', user_id: user.id.to_s, recipe_id: recipe.id.to_s)
    end

    it 'creates a new recipe' do
      expect(post: "/users/#{user.id}/recipes/#{recipe.id}/recipe_foods").to route_to('recipe_foods#create', user_id: user.id.to_s, recipe_id: recipe.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}/recipes/#{recipe.id}/recipe_foods/1").to route_to('recipe_foods#destroy', user_id: user.id.to_s, recipe_id: recipe.id.to_s, id: '1')
    end

    it 'routes to #edit' do
      expect(get: "/users/#{user.id}/recipes/#{recipe.id}/recipe_foods/1/edit").to route_to('recipe_foods#edit', user_id: user.id.to_s, recipe_id: recipe.id.to_s, id: '1')
    end

    it 'routes to #update' do
      expect(patch: "/users/#{user.id}/recipes/#{recipe.id}/recipe_foods/#{recipe_food.id}").to route_to('recipe_foods#update', user_id: user.id.to_s, recipe_id: recipe.id.to_s, id: recipe_food.id.to_s)
    end
  end
end
