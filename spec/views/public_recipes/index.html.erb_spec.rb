require 'rails_helper'

RSpec.describe 'public_recipes/index.html.erb', type: :view do
  describe 'The content of index page' do
    RecipeFood.destroy_all
    Food.destroy_all
    Recipe.destroy_all
    User.destroy_all
    before do
      sign_in User.first
      @recipe = Recipe.create(name: 'Pasta', description: 'Pasta with tomato sauce', user: User.first, public: true)
      assign(:public_recipes, [@recipe])
      render
    end

    it 'shows the div' do
      expect(rendered).to have_css('div.container.width')
    end

    it 'shows the text "Public Recipes" ' do
      expect(rendered).to have_content('Public Recipes')
    end

    it 'Shows the Add Food link' do
      expect(rendered).to have_content(@recipe.name)
    end

    it 'shows the owner of the recipe' do
      expect(rendered).to have_content(@recipe.user.name)
    end

    it 'shows the total food items' do
      expect(rendered).to have_content("Total food items: #{@recipe.foods.count}")
    end

    it 'shows the total food price' do
      expect(rendered).to have_content("Total price: $#{@recipe.foods.sum(:price)}")
    end
  end

  describe 'The links on the index page' do
    before do
      @user = User.first
      sign_in @user
      @recipe = Recipe.create(name: 'Pasta', description: 'Pasta with tomato sauce', user: @user, public: true)
      assign(:public_recipes, [@recipe]) # Assign the public_recipes variable
      render
    end

    it 'Should redirect to the recipe show page' do
      expect(rendered).to have_link(@recipe.name, href: user_recipe_path(@user, @recipe))
    end
  end
end
