class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: :received
  load_and_authorize_resource

  def index; end

  def received; end
end
