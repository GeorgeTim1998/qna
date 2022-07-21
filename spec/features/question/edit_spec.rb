require 'rails_helper'

feature 'User tries to edit question' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:another_user) { create(:user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

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
    
    scenario 'edits his question with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit question'
      
      within ".question-title-body" do
        fill_in 'Your question title', with: ''
        click_button 'Save'
        
        expect(page).to have_content question.body
        expect(page).to have_content question.title
      end
    end

    scenario "tries to edit other user's question" do 
      sign_in(another_user)
      visit question_path(question)
      
      expect(page).to_not have_link 'Edit answer'
    end

  end
end