require 'rails_helper'

feature 'Destroying the answer' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }

  scenario 'Authorized user tries to delete the answer' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content answer.body
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to have_no_content answer.body
  end

  scenario 'Unauthorized user tries to delete the answer'

  scenario 'Unauthenticated user tries to delete the answer'
end
