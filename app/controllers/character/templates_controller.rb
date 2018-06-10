require_relative 'api_presenters/template'

class Character::TemplatesController < ApplicationController
  before_action :set_template, only: [:show]

  # GET /templates
  def index
    templates = Character::Template.all
    json_response(
        templates.map { |n| Character::ApiPresenter::Template.format(n) }
    )
  end

  # GET /templates/:id
  def show
    json_response(Character::ApiPresenter::Template.format(@template))
  end

  private

  def set_template
    @template = Character::Template.find(params[:id])
  end
end
