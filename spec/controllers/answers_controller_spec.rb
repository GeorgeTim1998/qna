require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  subject(:question) { create(:question, author: user) }
  before { sign_in(user) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question.id } }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns @answer to @question' do
      expect(assigns(:answer).question).to eq question
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #create' do
    context 'with valid attributes' do
      before { get :new, params: { question_id: question.id } }

      it 'saves a new answer with a foreign key to the question to the database' do
        expect do
          post :create,
               params: { question_id: question.id, answer: attributes_for(:answer) }
        end.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      before { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }

      it 'doesnt save a new answer with invalid parameters' do
        expect { response }.to_not change(question.answers, :count)
      end

      it 'renders questions/show template' do
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }

    context 'when the user is the author' do
      let!(:answer) { create(:answer, author: user, question: question) }

      it 'deletes the answer from the database' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to index' do
        expect(delete(:destroy, params: { id: answer })).to redirect_to root_path
      end
    end

    context 'when the user is not the author' do
      let(:another_user) { create(:user) }
      let!(:answer) { create(:answer, author: another_user, question: question) }

      it 'does not delete the answer from the database' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to question/show' do
        expect(delete(:destroy, params: { id: answer })).to render_template 'questions/show'
      end
    end
  end
end
