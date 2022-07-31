class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: :received

  def index
    @achievements = Achievement.all
  end
end
