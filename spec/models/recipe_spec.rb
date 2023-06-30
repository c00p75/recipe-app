require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:all) do
    RecipeFood.destroy_all
    Food.destroy_all
    Recipe.destroy_all
    User.destroy_all
    @user = User.create(name: 'Cook', email: 'coor@masterchef.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'recipe 1', description: 'description', public: true)
  end

  it 'name should be present' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it 'descripton should be present' do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end
end
