class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    find_attachment
    @attachment.purge if current_user.author_of?(@attachment.record)
  end

  private

  def find_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end
