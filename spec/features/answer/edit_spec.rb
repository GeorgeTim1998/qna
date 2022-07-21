require 'rails_helper'

feature 'User can edit his answer' do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }
  given!(:another_user) { create(:user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end
  
  describe 'Authenticated user', js: true do
    scenario 'edits his answer' do
      sign_in user
      visit question_path(question)
      
      click_on 'Edit answer'
      
      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit answer'
      
      within '.answers' do
        fill_in 'Your answer', with: ''
        click_on 'Save'
        
        expect(page).to have_content answer.body
      end
    end
    
    scenario "tries to edit other user's question" do
      sign_in(another_user)
      visit question_path(question)
      
      expect(page).to_not have_link 'Edit answer'
    end
  end
end