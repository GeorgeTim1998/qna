require 'rails_helper'

feature do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:gist_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }
  given(:another_url) { 'https://www.google.com/' }

  scenario 'User adds link when asks question', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'My answer'

    within('#links') do
      click_on 'Add link'
      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: gist_url

      click_on 'Add link'

      within all('.nested-fields').last do
        fill_in 'Link name', with: 'Google'
        fill_in 'Url', with: another_url
      end
    end

    click_on 'Reply'

    within('.answers') do
      expect(page).to have_link 'My gist', href: gist_url
      expect(page).to have_link 'Google', href: another_url
    end
  end

  describe 'User edits an answer', js: true do
    before { sign_in(user) }
    given!(:question) { create(:question, author: user) }
    given!(:answer) { create(:answer, question: question, author: user) }
    given!(:link) { create(:link, linkable: answer) }
    before { visit question_path(question) }

    scenario 'and tries to add the link' do
      within(".answer-#{answer.id}") do
        click_on 'Edit answer'
        click_on 'Add link'

        within all('.nested-fields').last do
          fill_in 'Link name', with: 'MyGist'
          fill_in 'Url', with: gist_url
        end

        click_on 'Save'
      end

      within('.answers') do
        expect(page).to have_link link.name, href: link.url
        expect(page).to have_link 'MyGist', href: gist_url
      end
    end
  end
end
