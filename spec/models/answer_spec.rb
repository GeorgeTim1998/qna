require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    include_examples 'shared associations'
  end

  context 'with author' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
    it { should have_many(:links).dependent(:destroy) }
    it { should accept_nested_attributes_for :links }
  end

  include_examples 'shared methods', :answer, :answer_with_votes

  describe 'best' do
    subject(:answer) { build(:answer, best: true) }

    context 'true' do
      before { allow(answer).to receive(:best).and_return(true) }

      it { is_expected.to validate_uniqueness_of(:best).scoped_to(:question_id) }
    end

    context 'false' do
      before { allow(answer).to receive(:best).and_return(false) }

      it { is_expected.not_to validate_uniqueness_of(:best).scoped_to(:question_id) }
    end
  end
end
