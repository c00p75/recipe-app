require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  before(:each) do
    User.last.foods.destroy_all
    User.last.destroy
    @user = User.create(name: 'Cook', email: 'cheffu@masterchef.com', password: '123456', confirmed_at: Time.now)
    sign_in @user
    @food = Food.create(name: 'food1', price: 12, quantity: 3, measurement_unit: 'grams', user: @user)

    @foods = @user.foods
    render
  end
  describe 'The content of index page' do
    it 'shows the table' do
      expect(rendered).to have_css('table.table-striped')
    end
    it 'shows the text "Food" ' do
      expect(rendered).to have_content('Food')
    end
    it 'Shows the text "Measurement unit"' do
      expect(rendered).to have_content('Measurement unit')
    end
    it 'Shows the Add Food link' do
      expect(rendered).to have_content('Add Food')
    end
    it 'shows the name of the food added' do
      expect(rendered).to have_content(@food.name)
    end
    it 'shows the price of the food added' do
      expect(rendered).to have_content(@food.price)
    end
    it 'shows the measurement unit of the food added' do
      expect(rendered).to have_content(@food.measurement_unit)
    end
    it 'shows the quantity of the food added' do
      expect(rendered).to have_content(@food.quantity)
    end
    it 'Should have a button to delete a food' do
      expect(rendered).to have_button('Delete', exact: true, class: 'btn btn-outline-danger border-0')
    end
  end
  describe 'The links on the index page' do
    it 'Should redirect to the foods new page' do
      expect(rendered).to have_link('Add Food', href: new_user_food_path(@user))
    end
  end
end
