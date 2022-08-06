require 'rails_helper'

feature 'User can create question' do
  given!(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path

      click_on 'Ask question'
    end

    scenario 'creates a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text'

      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text'
    end

    scenario 'creates a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asks a question with attached file' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to create a question ' do
    visit root_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'All users see created question', js: true do
    Capybara.using_session('user') do
      sign_in(user)
      visit new_question_path
    end

    Capybara.using_session('guest') do
      visit root_path
    end

    Capybara.using_session('user') do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Some text'
      click_on 'Ask'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'Some text'
    end

    Capybara.using_session('guest') do
      expect(page).to have_content 'Test question'
    end
  end
end
