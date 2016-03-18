class WritersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :profile_stories]

  def index
    @writers = User.order(created_at: :desc).page(params[:page]) #kaminari
  end

  def show
    @writer = User.find(params[:id])
    @recent_chapters = @writer.chapters.limit(3).order('updated_at DESC')
  end

  def profile
    @writer = current_user
    @recent_chapters = @writer.chapters.limit(3).order('updated_at DESC')
    render :show
  end

  def my_stories
    @stories = current_user.stories
  end
end