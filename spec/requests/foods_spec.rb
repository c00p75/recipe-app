require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.first
    @food = Food.create(name: 'pasta', measurement_unit: 'grams', price: '$20', quantity: 2, user: @user)
    sign_in @user
  end

  describe 'GET /users/:user_id/foods' do
    before(:each) do
      get user_foods_path(@user)
    end
    it 'return successful response' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders foods/index template' do
      expect(response).to render_template(:index)
    end
    it "response body should include Add Food link" do
      get user_foods_path(@user)
      expect(response.body).to include("div")  
    end
    it "response body should include table" do
      expect(response.body).to include ('table')
    end
  end
  describe 'GET /users/:user_id/foods/new' do
    before(:each) do
      get new_user_food_path(@user)
    end
    it 'renders successful response' do
      expect(response).to be_successful
    end
    it 'renders foods/new template' do
      expect(response).to render_template(:new)
    end
    it "response body should include section" do
      expect(response.body).to include ('section')
    end
  end

  describe 'POST /users/:user_id/foods/create' do
    before(:all) do
      @user = User.first
      @valid_params = {food: { name: 'Apple', measurement_unit: 'Piece', price: '$1.99', quantity: 5, user: @user}}
    end
    context 'with invalid parameters' do
      let(:invalid_params) { { food: { name: nil, measurement_unit: 'Piece', price: 1.99, quantity: 5 } } }
    
      it 'does not create a new food' do
        expect {
          post user_foods_path(@user), params: invalid_params
        }.not_to change(Food, :count)
      end
    
      it 'renders the new template' do
        post user_foods_path(@user), params: invalid_params
        expect(response).to render_template(:new)
      end
    end    
  end
end