require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
    it { is_expected.to have_many(:achievements) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:subscribed_to).through(:subscriptions) }
  end

  describe '#author_of?' do
    let(:user) { create(:user) }

    subject { user }

    context 'when user is the author' do
      let(:resource) { create(:question, author: user) }

      it { is_expected.to be_author_of(resource) }
    end

    context 'when user is not the author' do
      let(:resource) { create(:question) }

      it { is_expected.not_to be_author_of(resource) }
    end
  end
end
