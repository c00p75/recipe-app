require 'rails_helper'

RSpec.describe 'users/:id/recipes', type: :request do
  include Devise::Test::IntegrationHelpers

  before(:all) do
    @user = User.create(name: 'Cook', email: 'cook5@masterchef.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'recipe 1', description: 'description', public: true)
  end

  describe 'GET /new' do
    before do
      sign_in @user
      get new_user_recipe_path(@user)
    end

    it 'should return response status correct (ok)' do
      expect(response).to have_http_status(:ok)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'New recipe'
    end
  end

  describe 'POST /create' do
    before do
      sign_in @user
    end

    it 'creates a new recipe' do
      expect do
        post user_recipes_path(@user),
             params: { recipe: { user_id: @user.id, name: 'recipe 2', description: 'description', public: true } }
      end.to change(Recipe, :count).by(1)
    end

    # it 'redirects to the created recipe' do
    #   post user_recipes_path(@user),
    #        params: { recipe: { user_id: @user.id, name: 'recipe 3', description: 'description', public: true } }
    #   expect(response).to redirect_to(assigns(:recipe))
    # end
  end

  describe 'GET /index' do
    before(:example) do
      sign_in @user
      get user_recipes_path(@user)
    end

    it 'response should be successful' do
      expect(response).to be_successful
    end

    it 'should correctly render index template' do
      expect(response).to render_template(:index)
    end

    it 'should contain placeholder text' do
      expect(response.body).to include('Recipes')
    end
  end

  describe 'DELETE /destroy' do
    before do
      sign_in @user
      @recipe = Recipe.create(user: @user, name: 'recipe 5', description: 'description', public: true)
    end

    it 'should destroy the recipe' do
      expect do
        delete user_recipe_path(@user, @recipe)
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the user recipes page' do
      delete user_recipe_path(@user, @recipe)
      expect(response).to redirect_to(user_recipes_path(@user))
    end
  end
end
