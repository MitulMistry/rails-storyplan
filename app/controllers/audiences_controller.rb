class AudiencesController < ApplicationController
  def index
    @audiences = Audience.all
  end

  def show
    @audience = Audience.find(params[:id])
  end
end
