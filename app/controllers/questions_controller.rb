class QuestionsController < ApplicationController
  include VotedFor

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[destroy show]

  after_action :publish_question, only: :create

  def new
    @question = Question.new
    @question.links.new
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

  def update
    find_question
    @question.update(question_params) if current_user.author_of?(@question)
  end

  def show
    find_question
    @answer = @question.answers.build
    @answer.links.new
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
    params.require(:question).permit(:title, :body, files: [],
                                                    links_attributes: %i[id name url _destroy],
                                                    achievement_attributes: %i[id name image])
  end

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast('questions', 
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
