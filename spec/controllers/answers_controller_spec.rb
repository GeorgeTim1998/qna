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
end
