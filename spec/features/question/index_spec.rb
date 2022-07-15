require 'rails_helper'

feature 'View list of questions' do
  describe "User views table of questions" do
    background { visit root_path }
  
    scenario 'with headers: title, body' do
      expect(page).to have_content('Title')
      expect(page).to have_content('Body')
    end
  end
  
  describe "User views table questions" do
    given!(:question) { create(:question) }
    background { visit root_path }

    scenario 'with question contents' do
      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)
    end
  end
end
