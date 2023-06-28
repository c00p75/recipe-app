require 'rails_helper'
RSpec.describe 'foods/new', type: :view do
  before(:each) do
    User.last.foods.destroy_all
    User.last.destroy
    @user = User.create(name: 'Cook', email: 'cheffu@masterchef.com', password: '123456', confirmed_at: Time.now)
    sign_in @user

    assign(:Food, Food.new) # Assign a new recipe object to the view
    render
  end
  describe 'Add New Food page' do
    it 'displays the form heading for adding a new food' do
      expect(rendered).to have_selector('h2', text: 'Add New Food')
    end
    it 'displays the form for adding a new food' do
      expect(rendered).to have_field('Name')
    end
    it 'displays the form for adding a new food' do
      expect(rendered).to have_field('Measurement unit')
    end
    it 'displays the form for adding a new food' do
      expect(rendered).to have_field('Price')
    end
    it 'displays the form for adding a new food' do
      expect(rendered).to have_field('Quantity')
    end
    it 'displays the form for adding a new food' do
      expect(rendered).to have_button('Create Food')
    end
  end
end
