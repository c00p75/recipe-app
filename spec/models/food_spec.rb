require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:all) do
    @food = Food.create(name: 'pasta', measurement_unit: 'grams', price: 1.99, quantity: 2)
  end

  it 'should name be present' do
    @food.name = nil
    expect(@food).to_not be_valid
  end

  it 'should price be present' do
    @food.price = nil
    expect(@food).to_not be_valid
  end

  it 'should price be an integer' do
    @food.price = 'string'
    expect(@food).to_not be_valid
    @food.price = 0
    expect(@food).to_not be_valid
  end

  it 'should measurement_unit be present' do
    @food.measurement_unit = nil
    expect(@food).to_not be_valid
  end

  it 'should quantity be present' do
    @food.quantity = nil
    expect(@food).to_not be_valid
  end

  it 'should quantity be greater than or equal to 1' do
    @food.quantity = -1
    expect(@food).to_not be_valid
  end
end
