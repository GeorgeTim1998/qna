class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: :received

  def index
    @achievements = Achievement.all
  end

  def received
    @achievements = current_user.achievements
  end
end
