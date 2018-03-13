# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  before :each do
    visit new_user_path
  end
  scenario 'has a new user page' do
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    it "takes a username and password" do
      expect(page).to have_field("Username", type: :text)

      expect(page).to have_field("Password", type: :password)

      expect(page).to have_field("Sign Up", type: :submit)
    end

    scenario 'shows username on the homepage after signup' do
      fill_in 'Username', with: 'Mr. Poopy Butthole'
      fill_in 'Password', with: 'password'
      click_button 'Sign Up'

      expect(page).to have_button('Sign Out')
      expect(page).to have_content 'Mr. Poopy Butthole'
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do

    fill_in 'Username', with: 'Mr. Poopy Butthole'
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'

    click_button 'Sign Out'

    fill_in 'Username', with: 'Mr. Poopy Butthole'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content 'Mr. Poopy Butthole'
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    expect(page).to have_link ('Sign Up')
  end
  scenario 'doesn\'t show username on the homepage after logout' do
    fill_in 'Username', with: 'Mr. Poopy Butthole'
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'

    click_button 'Sign Out'

    expect(page).not_to have_content 'Mr. Poopy Butthole'
  end

end
