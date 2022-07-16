require 'rails_helper'

feature 'Create answer' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, author: user) }

  scenario 'Authorized user tries to delete the question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content question.title

    click_on 'Delete question'

    expect(page).to have_content 'Your question successfully deleted.'
    expect(page).to have_no_content question.title
  end

  scenario 'Unauthorized user tries to delete the question' do
    sign_in(another_user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_no_content 'Delete the question'
  end

  scenario 'Unauthenticated user tries to delete the question' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_no_content 'Delete the question'
  end

end