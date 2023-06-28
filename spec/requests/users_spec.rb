require 'rails_helper'

RSpec.describe '/users', type: :request do
  include Devise::Test::IntegrationHelpers
  before(:all) do
    @user = User.create(name: "Cook", email: "chef@masterchef.com", password: "123456", confirmed_at: Time.now)
  end

  describe 'GET /index' do
    before do
      sign_in @user
      get root_path
    end
    it 'response should be successful' do
      expect(response).to be_successful
    end

    it 'should correctly render index template' do
      expect(response).to render_template(:index)
    end

    it 'should contain placeholder text' do
      expect(response.body).to include('Users')
    end
  end
end
