require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    include_examples 'shared associations'

    it { should have_many(:answers).dependent(:destroy) }
    it { should have_one(:achievement).dependent(:destroy) }
  end

  context 'with author' do
    it { is_expected.to belong_to(:author).class_name('User') }
    it { is_expected.to accept_nested_attributes_for(:achievement) }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
    it { should accept_nested_attributes_for :links }
  end

  include_examples 'shared methods', :question, :question_with_votes
end
