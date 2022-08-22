require 'rails_helper'

feature 'Author of the answer gets achievement' do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let!(:answer) { create(:answer, question: question, author: another_user) }
  let!(:achievement) { create(:achievement, question: question) }

  scenario 'The author of the best answer gets an achievement', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Best'

    click_on 'Log out'
    sign_in(another_user)
    visit received_achievements_path

    expect(page).to have_content achievement.name
  end
end
