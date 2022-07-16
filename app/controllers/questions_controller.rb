class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def new
    @question = Question.new
  end

  def index
    @questions = Question.all
  end

  def destroy
    find_question
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to root_path, notice: 'Your question successfully deleted.'
    else
      render 'questions/show'
    end
  end

  def show
    find_question
    @answer = @question.answers.build
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
