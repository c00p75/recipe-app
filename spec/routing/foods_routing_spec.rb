require 'rails_helper'

RSpec.describe FoodsController, type: :routing do
  let(:user) { User.create(name: 'Cook', email: 'cook45@masterchef.com', password: '123456', confirmed_at: Time.now) }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "/users/#{user.id}/foods").to route_to('foods#index', user_id: user.id.to_s)
    end

    it 'routes to #new' do
      expect(get: "/users/#{user.id}/foods/new").to route_to('foods#new', user_id: user.id.to_s)
    end

    it 'routes to #create' do
      expect(post: "/users/#{user.id}/foods").to route_to('foods#create', user_id: user.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}/foods/1").to route_to('foods#destroy', user_id: user.id.to_s, id: '1')
    end
  end
end
