require 'rails_helper'

RSpec.describe 'recipes/show', type: :view do
  before(:example) do
    @user = User.create(name: 'Cook', email: 'judy2010@masterchef.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user_id: @user.id, name: 'recipe 1', description: 'description', public: true)
    @food = Food.create(name: 'pasta', measurement_unit: 'grams', price: 20, quantity: 2, user: @user)
    @recipe_food = RecipeFood.create(food_id: @food.id, recipe_id: @recipe.id, quantity: 1)
    @recipe_foods = [@recipe_food]
    sign_in @user

    # assign(:recipe, Recipe.create(user_id: @user.id, name: 'recipe 1', description: 'description', public: true))
    render # Render the view
  end

  it 'displays the recipe form' do
    expect(rendered).to have_selector('h1')
  end
end
