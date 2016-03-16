class AudiencesController < ApplicationController
  def index
    @audiences = Audience.all
  end

  def show
    @audience = Audience.find(params[:id])
    @audience_stories = @audience.stories.order(created_at: :desc).page(params[:page]) #kaminari
  end
end
