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

    scenario 'asks a answer with attached file' do
      fill_in 'Body', with: 'Some text'
      click_on 'Reply'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Reply'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'tries to send an answer' do
      visit question_path(question)

      expect(page).to_not have_content 'Reply'
    end
  end
end
