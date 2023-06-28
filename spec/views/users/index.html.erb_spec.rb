require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:example) do
    @user1 = User.create(name: 'Gordon Ramsay', email: 'chef0@masterchef.com', password: '123456',
                         confirmed_at: Time.now)
    @user2 = User.create(name: 'Cook', email: 'chef102@masterchef.com', password: '123456', confirmed_at: Time.now)
    @users = [@user1, @user2]
    # Render the view
    render
  end

  it 'displays a list of Users' do
    expect(rendered).to have_content 'Users'
    expect(rendered).to have_content 'Gordon Ramsay'
    expect(rendered).to have_content 'Cook'
  end

  it 'should have link to view foods' do
    expect(rendered).to have_link('View Foods', href: user_foods_path(@user1))
    expect(rendered).to have_link('View Foods', href: user_foods_path(@user2))
  end

  it 'should have link to view recipes' do
    expect(rendered).to have_link('View Recipes', href: user_recipes_path(@user1))
    expect(rendered).to have_link('View Recipes', href: user_recipes_path(@user2))
  end
end
