require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    before { sign_in(user) }

    context 'with valid attributes' do
      subject(:request_for_creation) do
        post :create, params: { question_id: question.id, comment: { body: 'Comment body', commentable: question } },
                      format: :js
      end

      it { expect { request_for_creation }.to change(question.comments, :count).by(1) }
      it { expect { request_for_creation }.to have_broadcasted_to("questions/#{question.id}") }
    end

    context 'with invalid attributes' do
      subject(:request_for_creation) do
        post :create, params: { question_id: question.id, comment: { body: '', commentable: question } }, format: :js
      end

      it { expect { request_for_creation }.not_to change(question.class, :count) }
      it { expect { request_for_creation }.not_to have_broadcasted_to("questions/#{question.id}") }
    end
  end
end
