class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)    
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
