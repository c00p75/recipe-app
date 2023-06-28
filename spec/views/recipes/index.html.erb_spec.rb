require 'rails_helper'

RSpec.describe 'recipes/index', type: :view do
  before(:example) do
    @user = User.create(name: 'Cook', email: 'cook007@masterchef.com', password: '123456', confirmed_at: Time.now)
    sign_in @user

    # Create some recipes for the user
    @recipe1 = Recipe.create(user_id: @user.id, name: 'recipe 1', description: 'description', public: true)
    @recipe2 = Recipe.create(user_id: @user.id, name: 'recipe 2', description: 'description', public: true)

    # Fetch the recipes and assign them to @recipes
    @recipes = Recipe.where(user_id: @user.id)

    # Render the view
    render
  end

  it 'displays a list of recipes' do
    expect(rendered).to have_content 'Recipes'
    expect(rendered).to have_content 'recipe 1'
    expect(rendered).to have_content 'recipe 2'
  end

  it 'clicks on the "Add recipe" link' do
    expect(rendered).to have_link('Add recipe', href: new_user_recipe_path(user_id: @user.id))
  end

  it 'clicks on the "Delete" link for a recipe' do
    expect(rendered).to have_link('Delete', href: user_recipe_path(user_id: @user.id, id: @recipe1.id))
  end

  it 'clicks on a recipe' do
    expect(rendered).to have_link('recipe 1', href: user_recipe_path(user_id: @user.id, id: @recipe1.id))
    expect(rendered).to have_link('recipe 2', href: user_recipe_path(user_id: @user.id, id: @recipe2.id))
  end
end
