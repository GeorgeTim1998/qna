require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { should have_many(:answers).dependent(:destroy) }
  end

  context 'with author' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
  end
end
