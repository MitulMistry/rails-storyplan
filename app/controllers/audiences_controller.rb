class AudiencesController < ApplicationController
  def index
    @audiences = Audience.all
  end

  def show
    @audience = Audience.find(params[:id])
    @audience_stories = @audience.ordered_stories.page(params[:page]) #kaminari
  end
end
