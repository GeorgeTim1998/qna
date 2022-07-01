require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  subject(:question) { create(:question) }

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

  describe "GET #create" do
    context 'with valid attributes' do
      before { get :new, params: { question_id: question.id } }

      it 'saves a new answer with a foreign key to the question to the database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end
      
      it "redirects to show view" do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
        expect(response)  
      end
    end

    context 'with invalid attributes' do

    end
  end
  
end
