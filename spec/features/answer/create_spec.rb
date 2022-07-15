require 'rails_helper'

feature 'Create answer' do
  given(:question) { create(:question) }

  describe 'Authenticated user'  do
    given(:user) { create(:user) }

    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'tries to answer' do
      fill_in 'Body', with: 'Some text'
      click_on 'Reply'
      
      expect(page).to have_content 'Your answer has been sent successfully.'
      expect(page).to have_content 'Some text'
    end

    scenario 'tries to send an answer with errors' do
      click_on 'Reply'
      save_and_open_page
      
      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'tries to send an answer'
  end
end