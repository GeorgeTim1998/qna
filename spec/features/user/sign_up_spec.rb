require 'rails_helper'

feature 'User signs up' do
  background { visit new_user_registration_path }

  scenario 'with valid params' do
    fill_in 'Email', with: 'my@string.com'
    fill_in 'Password', with: 'MyString'
    fill_in 'Password confirmation', with: 'MyString'

    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'with invalid params' do
    click_on 'Sign up'
    expect(page).to have_content 'errors prohibited this user from being saved:'
  end
end
