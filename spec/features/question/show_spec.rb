require 'rails_helper'

feature 'View a questions with answers' do
  given(:question) { create(:question_with_answers) }
  background { visit question_path(question) }

  scenario 'Any user sees the questions' do
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Any user sees the answers' do
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end