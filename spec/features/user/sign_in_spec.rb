require 'rails_helper'

feature 'User can sign in' do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'user@test.com', password: '13245679')

    visit new_user_session_path

    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '13245679'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Unregistered user tries to sign in' do
  end
end
