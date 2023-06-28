require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:all) do
    @user = User.create(name: "Cook", email: "cooker@masterchef.com", password: "123456", confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'recipe 1', description: 'description', public: true)
  end

  it 'should name be present' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it 'should price be present' do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end
end
