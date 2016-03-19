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

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
      else
        format.html { render :new, alert: 'Character creation failed.' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
      else
        format.html { render :edit, alert: 'Character update failed.' }
      end
    end
  end

  def destroy
      @character.destroy

      respond_to do |format|
        format.html { redirect_to my_stories_path, notice: 'Character was successfully deleted.' }
      end
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
