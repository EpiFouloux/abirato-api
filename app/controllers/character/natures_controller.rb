require_relative 'api_presenters/nature'

class Character::NaturesController < ApplicationController
  before_action :set_nature, only: [:show]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /natures
  def index
    natures = Character::Nature.all
    json_response(
      natures.map { |n| Character::ApiPresenter::Nature.format(n) }
    )
  end

  # GET /natures/:id
  def show
    json_response(Character::ApiPresenter::Nature.format(@nature))
  end

  private

  def set_nature
    @nature = Character::Nature.find(params[:id])
  end
end
