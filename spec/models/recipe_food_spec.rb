require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:all) do
    @user = User.create(name: 'Cook', email: 'cooksmith@masterchef.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user_id: @user, name: 'recipe 1', description: 'description', public: true)
    @food = Food.create(name: 'pasta', measurement_unit: 'grams', price: '$20', quantity: 2)
    @recipe_food = RecipeFood.create(food_id: @food, recipe_id: @recipe, quantity: 1)
  end

  it 'quantity should be present' do
    @recipe_food.quantity = nil
    expect(@recipe_food).to_not be_valid
  end
end