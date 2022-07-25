require 'rails_helper'

feature 'Editing the files' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question, files: find_file('README.md')) }

  describe 'Authorized user', js: true do
    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'tries to add files' do
      within(".answer-#{answer.id}") do
        click_on 'Edit answer'
        attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'
      end

      within '.answer-file' do
        expect(page).to have_link 'README.md'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end

  scenario 'Unauthorized user tries to edit attached files' do
    sign_in(another_user)
    visit question_path(question)
    save_and_open_page

    within(".answers") do
      expect(page).to have_link 'README.md'
      expect(page).to have_no_content 'Edit the question'
    end
  end

  scenario 'Unauthenticated user tries to edit attached files' do
    visit question_path(question)

    within(".answers") do
      expect(page).to have_link 'README.md'
      expect(page).to have_no_content 'Edit the question'
    end
  end
end
