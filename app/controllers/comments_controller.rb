class CommentsController < ApplicationController
  before_action :find_resource

  def create
    @comment = @resource.comments.build(comment_params)
    @comment.author = current_user
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_resource
    @resource = Answer.find_by(id: params[:answer_id]) || Question.find_by(id: params[:question_id])
  end
end
