require 'rails_helper'

feature 'User can create question' do
  given(:user) { User.create!(email: 'user@test.com', password: '13245679') }

  
  scenario 'Authenticated user creates a question' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    
    visit root_path
    
    click_on 'Ask question'
    
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    
    click_on 'Ask'
    
    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text'
  end
  
  scenario 'Authenticated user creates a question with errors' do
  end
  
  scenario 'Unauthenticated user tries to create a question ' do
    visit root_path
    click_on 'Ask question'    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    
  end
end