class WritersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :profile_stories, :edit_profile]
  before_action :set_user, only: [:profile, :edit_profile, :update_profile]

  def index
    @writers = User.order(created_at: :desc).page(params[:page]) #kaminari
  end

  def show
    @writer = User.find(params[:id])
    @recent_chapters = @writer.recent_chapters
  end

  def profile
    @recent_chapters = @writer.recent_chapters
    render :show
  end

  def edit_profile
  end

  def update_profile
    if @writer.update(user_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit_profile, alert: 'Profile update failed.'
    end
  end

  def my_stories
    @stories = current_user.stories.order('updated_at DESC')
    @current_chapters = current_user.chapters.currently_writing #using scope method
  end

  #-------------------------------
  private

  def set_user
    @writer = current_user
  end

  def user_params #strong params
    params.require(:user).permit(:email, :username, :fullname, :bio)
  end
end