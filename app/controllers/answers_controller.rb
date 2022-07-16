class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[new create]

  def new
    @answer = @question.answers.build
  end

  def show; end

  def destroy
    find_answer
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to root_path
    else
      render 'questions/show'
    end
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to question_path(@answer.question), notice: 'Your answer has been sent successfully.'
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
