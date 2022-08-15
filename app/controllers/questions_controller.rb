class QuestionsController < ApplicationController
  include VotedFor

  before_action :authenticate_user!, only: :new

  load_and_authorize_resource

  before_action :set_variables, only: :show

  def new
    @question.links.new
  end

  def index; end

  def destroy
    @question.destroy
    redirect_to root_path, notice: 'Your question successfully deleted.'
  end

  def update
    render_errors(@question) unless @question.update(question_params)
  end

  def show; end

  def create
    @question.author = current_user

    if @question.save
      publish_question
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                                    links_attributes: %i[id name url _destroy],
                                                    achievement_attributes: %i[id name image])
  end

  def set_variables
    @answer = Answer.new
    @answer.links.new
    @comment = Comment.new
    @comments = @question.comments.includes(:author)
    @answers = @question.answers.with_attached_files.includes(:author,
                                                              :links,
                                                              comments: :author)
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast('questions',
                                 ApplicationController.render(
                                   partial: 'questions/question',
                                   locals: { question: @question }
                                 ))
  end
end
