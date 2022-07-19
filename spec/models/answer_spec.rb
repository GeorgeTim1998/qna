require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to(:question) }
  end

  context 'with author' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
  end
end
