require 'rails_helper'

RSpec.describe RecipesController, type: :routing do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Cook', email: 'cook1@masterchef.com', password: '123456', confirmed_at: Time.now) }
  let(:recipe) { Recipe.create(user:, name: 'recipe 1', description: 'description', public: true) }

  describe 'recipe routing' do
    before do
      sign_in user
    end
    it 'routes to #index' do
      expect(get: "/users/#{user.id}/recipes").to route_to('recipes#index', user_id: user.id.to_s)
    end
    it 'routes to #new' do
      expect(get: "/users/#{user.id}/recipes/new").to route_to('recipes#new', user_id: user.id.to_s)
    end
    it 'routes to #show' do
      expect(post: "/users/#{user.id}/recipes").to route_to('recipes#create', user_id: user.id.to_s)
    end
    it 'creates a new recipe' do
      expect(post: "/users/#{user.id}/recipes").to route_to('recipes#create', user_id: user.id.to_s)
    end
    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}/recipes/#{recipe.id}").to route_to('recipes#destroy', user_id: user.id.to_s,
                                                                                              id: recipe.id.to_s)
    end
  end
end
