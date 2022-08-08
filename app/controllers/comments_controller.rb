class CommentsController < ApplicationController
  before_action :find_resource
  before_action :gon_variables

  after_action :publish_comment

  def create
    @comment = @resource.comments.build(comment_params)
    @comment.author = current_user
    @comment.save
  end

  private

  def publish_comment
    return unless @comment.persisted?

    ActionCable.server.broadcast("questions/#{gon.question_id}",
                                 { css: "#{@resource.class}-comments".downcase,
                                   template: ApplicationController.render(partial: 'comments/comment',
                                                                          locals: { comment: @comment }) })
  end

  def gon_variables
    gon.question_id = @resource.id if @resource.instance_of?(Question)
    gon.question_id = @resource.question.id if @resource.instance_of?(Answer)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_resource
    @resource = Answer.find_by(id: params[:answer_id]) || Question.find_by(id: params[:question_id])
  end
end
