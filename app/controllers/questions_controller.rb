class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def new
    @question = Question.new
  end

  def index; end

  def show
    find_question
  end
  
  def create
    @question = Question.new(question_params)

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
