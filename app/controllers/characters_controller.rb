class CharactersController < ApplicationController
  before_action :find_character, only: [:show, :edit, :update, :destroy]
  before_action :authorize_ownership, only: [:edit, :update, :destroy]

  def index #?
    @characters = Character.order(created_at: :desc).page(params[:page]) #kaminari
  end

  def show
  end

  def new
    @character = Character.new
  end

  def create
    @character = current_user.characters.build(character_params)
    if @character.save
      redirect_to @character, notice: 'Character was successfully created.'
    else
      render :new, alert: 'Character creation failed.'
    end
  end

  def edit
  end

  def update
    if @character.update(character_params)
      redirect_to @character, notice: 'Character was successfully updated.'
    else
      render :edit, alert: 'Character update failed.'
    end    
  end

  def destroy
    @character.destroy
    redirect_to my_stories_path, notice: 'Character was successfully deleted.'      
  end

  #-------------------------------
  private

  def find_character
    @character = Character.find(params[:id])
  end

  def authorize_ownership
    if @character.user != current_user
      redirect_to characters_path, alert: 'You do not have required permissions.'
    end
  end

  def character_params #strong params
    params.require(:character).permit(:name, :bio, :traits, chapter_ids: [])
  end
end
