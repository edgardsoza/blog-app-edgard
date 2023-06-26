require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', photo: 'https://via.placeholder.com/150', bio: 'Programmer', posts_counter: 0)
    @user.save
    visit users_path
  end

  it 'displays the username of all other users' do
    expect(page).to have_content('John')
  end

  it 'displays a placeholder profile picture for each user' do
    expect(page).to have_css("img[src*='https://via.placeholder.com/150']")
  end

  it 'displays the number of posts each user has written' do
    expect(page).to have_content('Number of Posts: 0')
  end

  it 'redirects to the user show page when a user is clicked' do
    click_link('User', match: :prefer_exact)
    expect(page).to have_content('Bio')
  end
end
