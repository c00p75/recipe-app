require 'rails_helper'

RSpec.describe 'recipes/new', type: :view do
  RecipeFood.destroy_all
  Food.destroy_all
  Recipe.destroy_all
  User.destroy_all
  before(:example) do
    @user = User.create(name: 'Cook', email: 'cook007@masterchef.com', password: '123456', confirmed_at: Time.now)
    sign_in @user

    assign(:recipe, Recipe.new) # Assign a new recipe object to the view
    render # Render the view
  end

  it 'displays the recipe form' do
    expect(rendered).to have_field('Name')
    expect(rendered).to have_field('Preperation Time')
    expect(rendered).to have_field('Cooking Time')
    expect(rendered).to have_field('Description')
    expect(rendered).to have_field('recipe_public')
    expect(rendered).to have_button('Create Recipe')
  end

  it 'displays validation errors' do
    @recipe = Recipe.new # Create a recipe with errors
    @recipe.errors.add(:name, 'cannot be blank')
    @recipe.errors.add(:description, 'is too short')

    assign(:recipe, @recipe) # Assign the recipe with errors to the view
    render # Render the view

    expect(rendered).to have_content('Name cannot be blank')
    expect(rendered).to have_content('Description is too short')
  end
end
