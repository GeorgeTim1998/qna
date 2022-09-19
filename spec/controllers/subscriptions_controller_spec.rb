require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  include ActionView::Helpers::UrlHelper

  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'POST #create' do
    let(:question) { create(:question) }

    subject(:request_for_creation) { post :create, params: { question_id: question.id, format: :js } }

    it { expect { request_for_creation }.to change(question.subscriptions, :count).by(1) }

    it do
      request_for_creation
      expect(response.body).to include link_to 'unsubscribe',
                                               question_subscription_path(question, assigns(:subscription)),
                                               class: 'unsubscribe', method: :delete, remote: true
    end
  end

  describe 'DELETE #destroy' do
    subject(:deletion_request) do
      delete :destroy, params: { question_id: subscription.question.id, id: subscription }, format: :js
    end

    let!(:subscription) { create(:subscription, user: user) }

    it { expect { deletion_request }.to change(Subscription, :count).by(-1) }

    it do
      deletion_request
      expect(response.body).to include link_to 'subscribe',
                                               question_subscriptions_path([subscription.question, subscription]),
                                               class: 'subscribe', method: :post, remote: true
    end
  end
end
