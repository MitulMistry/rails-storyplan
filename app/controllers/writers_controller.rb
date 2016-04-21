class WritersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :profile_stories, :edit_profile]
  before_action :get_user, only: :show
  before_action :set_current_user, only: [:profile, :edit_profile, :update_profile]
  before_action :get_recent, only: [:show, :profile]

  def index
    @writers = User.ordered.page(params[:page]) #kaminari
  end

  def show
  end

  def profile
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
    @stories = current_user.ordered_updated_stories
    @current_chapters = current_user.current_chapters
  end

  #-------------------------------
  private

  def get_user
    @writer = User.find(params[:id])
  end

  def set_current_user
    @writer = current_user
  end

  def get_recent
    @recent_stories = @writer.recent_stories
    @recent_chapters = @writer.recent_chapters
    @recent_characters = @writer.recent_characters
  end

  def user_params #strong params
    params.require(:user).permit(:email, :username, :fullname, :bio)
  end
end
