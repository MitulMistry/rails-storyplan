class CharactersController < ApplicationController
  before_action :find_character, only: [:show, :edit, :update, :destroy]
  
  def index #?
    @characters = Character.all
  end

  def show
  end

  def new
    @character = Character.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @character.destroy
  end
  
  #-------------------------------
  private
  def find_character
    @character = Character.find(params[:id])
  end
end
