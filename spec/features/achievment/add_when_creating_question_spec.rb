require 'rails_helper'

feature 'User can add achievement for the best answer when creating a question', js: true do
  let(:user) { create(:user) }
  let(:image_path) { "#{Rails.root}/storage/price.jpg" }

  before do
    sign_in(user)
    visit new_question_path
  end

  scenario 'tries to add an achievement' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    within('#achievement') do
      click_on 'Add achievement'
      fill_in 'Name', with: 'Achievement1'
      attach_file 'Image', image_path
    end

    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created.'

    visit achievements_path

    expect(page).to have_content 'Achievement1'
    expect(page).to have_xpath "//img[contains(@src, 'price')]"
  end
end
