class Character::InstancesController < ApplicationController

  before_action :set_user
  before_action :set_character, only: %i[show update destroy]

  # GET /users/:id/characters
  def index
    characters = Character::Instance.where(user: @user)
    json_response(
      characters.map { |c| ApiPresenter.format(c) }
    )
  end

  # GET /users/:id/characters/:id
  def show
    character = Character::Instance.find(params[:id])
    json_response(ApiPresenter.format(character))
  end

  # POST /users/:id/characters
  def create

  end

  # PUT /users/:id/characters/:id
  def update

  end

  # DELETE /users/:id/characters/:id
  def destroy

  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_character
    @character = Character.find(params[:id])
  end
end
