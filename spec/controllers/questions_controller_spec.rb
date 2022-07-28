require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    before { login(user) }

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'assigns new link for question' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    let!(:question) { create(:question, author: user) }  
    let!(:answer) { create(:answer, author: user) }  
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns new link for answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end


    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }

    it 'updates the question with inputted params' do
      patch :update, params: { id: question, question: { title: 'Question1 title', body: 'Question1 body' } },
                     format: :js

      question.reload

      expect(question.title).to eq 'Question1 title'
      expect(question.body).to eq 'Question1 body'
    end
  end

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new question to the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it "doesn't save a new question to the database" do
        expect do
          post :create, params: { question: attributes_for(:question, :invalid) }
        end.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    context 'when the user is the author' do
      let!(:question) { create(:question, author: user) }

      it 'deletes the question from the database' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to index' do
        expect(delete(:destroy, params: { id: question })).to redirect_to root_path
      end
    end

    context 'when the user is not the author' do
      let(:another_user) { create(:user) }
      let!(:question) { create(:question, author: another_user) }

      it 'does not delete the question from the database' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'redirects to question/show' do
        expect(delete(:destroy, params: { id: question })).to render_template 'questions/show'
      end
    end
  end
end
