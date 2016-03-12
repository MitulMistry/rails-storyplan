class WritersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :profile_stories]

  def index
    @writers = User.all
  end

  def show
    @writer = User.find(params[:id])
  end

  def profile
    @current_user = current_user
  end

  def my_stories
    @stories = current_user.stories
  end
end