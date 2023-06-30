require 'rails_helper'

RSpec.describe RecipeFood, type: :request do
  before(:all) do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
    @user = User.create(name: 'Cook', email: 'cooksmith@masterchef.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'recipe 1', description: 'description', public: true)
    @food = Food.create(name: 'pasta', measurement_unit: 'grams', price: 20, quantity: 2, user: @user)
    @recipe_food = RecipeFood.create(food_id: @food.id, recipe_id: @recipe.id, quantity: 1)
  end

  describe 'GET /new' do
    before do
      sign_in @user
      get new_user_recipe_recipe_food_path(user_id: @user.id, recipe_id: @recipe)
    end

    it 'should return response status correct (ok)' do
      expect(response).to have_http_status(:ok)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'Add Ingredient'
    end
  end

  describe 'POST /create' do
    before do
      sign_in @user
      post user_recipe_recipe_foods_path(user_id: @user.id, recipe_id: @recipe.id),
           params: { recipe_food: { recipe_id: @recipe.id, food_id: @food.id, quantity: 1 } }
    end

    it 'should return response status correct (ok)' do
      expect(response).to have_http_status(:found)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end
  end

  describe 'GET /edit' do
    before do
      sign_in @user
      get edit_user_recipe_recipe_food_path(@user.id, @recipe.id, @recipe_food.id)
    end

    it 'should return response status correct (ok)' do
      expect(response).to have_http_status(:ok)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'Edit Ingredient' do
      expect(response.body).to include 'Editing recipe food'
    end
  end

  describe 'PATCH /update' do
    before do
      sign_in @user
      patch user_recipe_recipe_food_path(@user.id, @recipe.id, @recipe_food.id),
            params: { recipe_food: { recipe_id: @recipe.id, food_id: @food.id, quantity: 1 } }
    end

    it 'should return response status correct (ok)' do
      expect(response).to have_http_status(:found)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end
  end

  describe 'DELETE /destroy' do
    before do
      sign_in @user
      delete user_recipe_recipe_food_path(user_id: @user.id, recipe_id: @recipe.id, id: @recipe_food.id)
    end

    it 'should return response status correct (ok)' do
      expect(response).to have_http_status(:found)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end
  end
end