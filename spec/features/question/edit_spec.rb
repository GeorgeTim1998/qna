require 'rails_helper'

feature 'User tries to edit question' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'edits his question' do
      sign_in user
      visit question_path(question)

      click_on 'Edit question'

      within ".question-title-body" do
        fill_in 'Your question title', with: 'Question1 title'
        fill_in 'Your question body', with: 'Question1 body'
        click_button 'Save'
        
        expect(page).to_not have_content question.body
        expect(page).to have_content 'Question1 title'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'is the author of the question and tries to edit it with invalid attributes'

    scenario 'is not the author of the question and doesnt edit it'

  end
  
  describe 'An anauthorized user', js: true do
    scenario 'cannot edit the answer'
  end

end