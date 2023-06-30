require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  describe 'GET /index' do
    before do
      sign_in User.first
      get '/'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders public_recipes/index template' do
      expect(response).to render_template(:index)
    end
    it 'response body should include div' do
      expect(response.body).to include('div')
    end
    it 'response body should include h1' do
      expect(response.body).to include('h1')
    end
  end
end
