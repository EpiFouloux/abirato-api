require_relative 'api_presenters/class'

class Character::ClassesController < ApplicationController
  before_action :set_class, only: [:show]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /classes
  def index
    classes = Character::Class.all
    json_response(
        classes.map { |c| Character::ApiPresenter::Class.format(c) }
    )
  end

  # GET /classes/:id
  def show
    json_response(Character::ApiPresenter::Class.format(@class))
  end

  private

  def set_class
    @class = Character::Class.find(params[:id])
  end
end
