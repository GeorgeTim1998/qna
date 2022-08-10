require 'rails_helper'

RSpec.shared_examples 'comment', js: true do |space|
  describe 'Authenticated user' do
    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'tries to add comment' do
      within(space) do
        click_on 'Add comment'

        fill_in 'Comment', with: 'Comment456'
        click_on 'Send'

        expect(page).to have_content 'Comment456'
      end
    end

    scenario 'tries to add comment with errors' do
      within(space) do
        click_on 'Add comment'
        click_on 'Send'

        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  scenario 'All users on question_path should see the created comment' do
    Capybara.using_session('user') do
      sign_in(user)
      visit question_path(question)
    end

    Capybara.using_session('guest') do
      visit question_path(question)
    end

    Capybara.using_session('user') do
      within(space) do
        click_on 'Add comment'
        fill_in 'Comment', with: 'Comment233'
        click_on 'Send'

        expect(page).to have_content 'Comment233'
      end
    end

    Capybara.using_session('guest') do
      within(space) do
        expect(page).to have_content 'Comment233'
      end
    end
  end
end

feature 'Authenticated user can add comment' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'for questions' do
    include_examples 'comment', '.question-comments'
  end

  describe 'for answers' do
    given!(:answer) { create(:answer, question: question, author: user) }

    include_examples 'comment', '.answer-comments'
  end
end
