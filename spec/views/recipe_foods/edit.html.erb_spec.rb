require 'rails_helper'
RSpec.describe 'recipe_foods/edit', type: :view do
  before(:each) do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
    @user = User.create(name: 'Cook', email: 'captaincook@masterchef.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'recipe 1', description: 'description', public: true)
    @food = Food.create(name: 'pasta', measurement_unit: 'grams', price: 20, quantity: 2, user: @user)
    @foods = [@food]
    # @recipe_food = RecipeFood.create(food_id: @food.id, recipe_id: @recipe.id, quantity: 1)
    sign_in @user

    assign(:recipe_food, RecipeFood.create!(food_id: @food.id, recipe_id: @recipe.id, quantity: 1))
    render
  end

  describe 'Add edit RecipeFood page' do
    it 'displays the form heading for adding a new recipefood' do
      expect(rendered).to have_selector('h1', text: 'Editing recipe food')
    end

    it 'displays the field for adding a new recipefood' do
      expect(rendered).to have_selector('p', text: 'Food name')
    end
    it 'displays the field for adding quantity' do
      expect(rendered).to have_selector('p', text: 'Quantity')
    end
  end
end
