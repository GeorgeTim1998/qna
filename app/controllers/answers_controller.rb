class AnswersController < ApplicationController
  include VotedFor

  before_action :authenticate_user!, only: :create

  load_and_authorize_resource :question
  load_and_authorize_resource :answer, through: :question, shallow: true

  def new
    @answer = @question.answers.build
  end

  def show; end

  def update
    render_errors(@answer) unless @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  def create
    @answer.author = current_user
    if @answer.save
      gon_variables
      publish_answer
    else
      render_errors(@answer)
    end
  end

  def best
    @question = @answer.question
    @question.update_best_answer(@answer)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [],
                                          links_attributes: %i[id name url _destroy])
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
                                                                          }) })
  end
end
