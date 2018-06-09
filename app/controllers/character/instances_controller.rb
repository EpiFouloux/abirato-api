require_relative 'api_presenters/instance'

class Character::InstancesController < ApplicationController

  before_action :set_user
  before_action :set_character, only: %i[show update destroy]

  # GET /users/:id/characters
  def index
    characters = Character::Instance.where(user: @user)
    json_response(
      characters.map { |c| Character::ApiPresenter::Instance.format(c) }
    )
  end

  # GET /users/:id/characters/:id
  def show
    json_response(Character::ApiPresenter::Instance.format(@character))
  end

  # POST /users/:id/characters
  def create
    params.require(:template_id)
    params.require(:name)
    params.require(:additive_trait)
    template = Character::Template.find(params[:template_id])
    raise ActiveModel::ForbiddenAttributesError, 'Additive trait is invalid' unless Character::Traits::TRAITS_NAMES.include? params[:additive_trait]
    key = "additive_#{params[:additive_trait]}"
    character = Character::Instance.new(
      template:       template,
      nature:         template.nature,
      name:           params[:name],
      user:           @user,
      level:          1,
    )
    character[key.to_sym] = 1
    character.save!
    json_response(Character::ApiPresenter::Instance.format(character), :created)
  end

  # PUT /users/:id/characters/:id
  def update
    permitted = params.permit(
      :name,
      :additive_trait,
      :additive_modifier
    )
    raise ActionController::ParameterMissing, "No allowed parameters provided" if permitted.blank?
    @character.name = permitted[:name] if permitted[:name]
    @character.experience_amount += permitted[:experience_amount] if permitted[:experience_amount]
    if permitted[:additive_trait]
      raise ActiveModel::ForbiddenAttributesError, 'Additive trait is invalid' unless Character::Traits::TRAITS_NAMES.include? params[:additive_trait]
      key = "additive_#{permitted[:additive_trait]}"
      @character[key.to_sym] += 1
    end
    if permitted[:additive_modifier]
      raise ActiveModel::ForbiddenAttributesError, 'Additive modifier is invalid' unless Character::Modifiers::MODIFIERS_NAMES.include? params[:additive_modifier]
      key = "additive_#{permitted[:additive_modifier]}"
      @character[key.to_sym] += 1
    end
    @character.save!
    json_response(Character::ApiPresenter::Instance.format(@character))
  end

  # DELETE /users/:id/characters/:id
  def destroy
    @character.destroy!
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_character
    @character = Character::Instance.find(params[:id])
  end
end
