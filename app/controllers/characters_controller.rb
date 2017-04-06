class CharactersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] #Devise authentication - check if user is logged in
  before_action :find_character, only: [:show, :edit, :update, :delete_portrait, :destroy]
  before_action :authorize_ownership, only: [:edit, :update, :delete_portrait, :destroy]

  def index
    if params[:writer_id] #check for nested route
      @characters = User.find(params[:writer_id]).characters.ordered.page(params[:page])
    else
      @characters = Character.ordered.page(params[:page]) #kaminari
    end
  end

  def show
  end

  def new
    @character = Character.new
  end

  def create
    @character = current_user.characters.build(character_params) #associate character to current user
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

  def delete_portrait
    @character.portrait = nil
    @character.save
    redirect_to @character, notice: 'Image was successfully deleted.'
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
      return #guard clause
    end
  end

  def character_params #strong params
    params.require(:character).permit(:name, :bio, :traits, :portrait, chapter_ids: [])
  end
end
