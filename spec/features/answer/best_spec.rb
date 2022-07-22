require 'rails_helper'
require 'pp'

feature 'Best answer' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  describe 'Authorized user', js: true do
    given!(:another_answer) { create(:answer, body: 'another answer body', question: question) }

    background { sign_in(user) }
    background { visit question_path(question) }
    scenario 'tries to choose another best answer' do
      within '.answers' do
        expect(page).to have_no_content 'Best answer'
        click_on 'Best'

        expect(page).to have_content 'Best answer'
        expect(page).to have_no_link 'Best'
      end
    end

    scenario 'tries to choose another best answer'
  end

  scenario 'Unauthorized user tries to choose the best answer' do
    sign_in(another_user)
    visit question_path(question)

    expect(page).to have_content answer.body
    expect(page).to have_no_content 'Best'
  end

  scenario 'Unauthenticated user tries to choose the best answer' do
    visit question_path(question)

    expect(page).to have_content answer.body
    expect(page).to have_no_content 'Best'
  end
end
