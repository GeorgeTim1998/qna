require 'rails_helper'

feature 'The user can view achievements.' do
  let(:user) { create(:user) }
  let!(:received_achievement) { create(:achievement, name: 'Achievement23', winner: user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit achievements_path
    end

    scenario 'tries view received achievements' do
      click_on 'Your achievements'

      expect(page).to have_content received_achievement.name
      expect(page).to have_content received_achievement.question.title
      expect(page).to have_xpath "//img[contains(@src, 'price')]"
    end
  end
end
