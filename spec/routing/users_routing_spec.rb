require 'rails_helper'

RSpec.describe RecipesController, type: :routing do
  describe 'user routing' do
    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end
  end
end
