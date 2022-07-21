require 'rails_helper'

feature 'Create answer', js: true do
  given(:question) { create(:question) }

  describe 'Authenticated user'  do
    given(:user) { create(:user) }

    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'tries to answer' do
      fill_in 'Body', with: 'Some text'
      click_on 'Reply'

      within '.answers' do
        expect(page).to have_content 'Some text'
      end
    end

    scenario 'tries to send an answer with errors' do
      click_on 'Reply'

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'tries to send an answer' do
      visit question_path(question)

      expect(page).to_not have_content 'Reply'
    end
  end
end
