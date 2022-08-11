require 'rails_helper'

feature 'Authenticated user can votes for a question', js: true do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:question) { create(:question, author: user) }

  describe 'Authenticated user' do
    before { sign_in(another_user) }

    scenario 'tries to increase question rating and cancel' do
      visit question_path(question)
      within('.voting') do
        expect(page).to have_content '0'

        click_on '+'

        expect(page).to have_content '1'
        expect(page).to have_no_link '+'

        click_on 'cancel'

        expect(page).to have_link '+'
        expect(page).to have_link '-'
      end
    end

    scenario 'tries to decrease question rating and cancel' do
      visit question_path(question)

      within('.voting') do
        expect(page).to have_content '0'

        click_on '-'

        expect(page).to have_content '-1'
        expect(page).to have_no_link '-'

        click_on 'cancel'

        expect(page).to have_link '+'
        expect(page).to have_link '-'
      end
    end
  end

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'tries to change his question rating' do
      visit question_path(question)

      within('.voting') do
        expect(page).to have_no_link '+'
        expect(page).to have_no_link '-'
        expect(page).to have_content question.rating
      end
    end
  end

  scenario 'Unauthenticated user tries to change the rating of the question' do
    visit question_path(question)
    within('.voting') do
      expect(page).to have_content question.rating
      
      expect(page).to have_no_link '+'
      expect(page).to have_no_link '-'
    end
  end
end
