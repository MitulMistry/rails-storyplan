class WritersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :profile_stories]

  def index
    @writers = User.all
    @counter = 0
  end

  def show
    @writer = User.find(params[:id])
    @recent_chapters = @writer.chapters.limit(3).order('updated_at')
  end

  def profile
    #@current_user = current_user
    @writer = current_user
    @recent_chapters = @writer.chapters.limit(3).order('updated_at')
    render :show
  end

  def my_stories
    @stories = current_user.stories
  end
end