class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class:  ActiveStorage::Attachment

  def destroy
    @attachment.purge
  end
end
