require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to(:question) }
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  context 'with author' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
    it { should have_many(:links).dependent(:destroy) }
    it { should accept_nested_attributes_for :links }
  end

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

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
