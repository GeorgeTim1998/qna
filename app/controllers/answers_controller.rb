class AnswersController < ApplicationController
  include VotedFor

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[new create]
  before_action :gon_variables, only: :create
  
  after_action :publish_answer, only: :create

  def new
    @answer = @question.answers.build
  end

  def show; end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    find_answer
    @question = @answer.question
    @answer.destroy if current_user.author_of?(@answer)
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def best
    find_answer
    @question = @answer.question
    @question.update_best_answer(@answer)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [],
                                          links_attributes: %i[id name url _destroy])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def gon_variables
    gon.push({
      question_id: @question.id
    })
  end

  def publish_answer
    return unless @answer.persisted?
    
    ActionCable.server.broadcast("questions/#{@question.id}",
                                 { css: 'answers',
                                   template: ApplicationController.render(partial: 'answers/answer_cable',
                                                                          locals: {
                                                                            answer: @answer
                                                                          }
                                                                          )})
  end
end
