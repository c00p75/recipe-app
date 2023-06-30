require 'rails_helper'

RSpec.describe 'shopping_list/index.html.erb', type: :view do
  describe 'The content of index page' do
    before do
      @shopping_list = [{ food: { name: 'pasta', measurement_unit: 'grams', price: 40, quantity: 3, user: User.first },
                          quantity: 4 }]
      @total_price = @shopping_list[0][:food][:price] * @shopping_list[0][:quantity]
      sign_in User.first
      render
    end

    it 'shows the div' do
      expect(rendered).to have_css('div.container.width')
    end

    it 'shows the text "Shopping List" ' do
      expect(rendered).to have_content('Shopping List')
    end
    it 'shows the table' do
      expect(rendered).to have_css('table.table-striped')
    end
    it 'shows the text "Food" ' do
      expect(rendered).to have_content('Food')
    end
    it 'Shows the text "Price"' do
      expect(rendered).to have_content('Price')
    end
    it 'Shows the text "Quantity"' do
      expect(rendered).to have_content('Quantity')
    end
    it 'shows the amount of food items to by' do
      expect(rendered).to have_content('Amount of food items to buy: 1')
    end

    it 'shows the total food price' do
      expect(rendered).to have_content('Total value of food needed: $160')
    end
  end
end
