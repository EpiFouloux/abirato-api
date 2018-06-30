require_relative 'api_presenters/event'

class Character::EventsController < ApplicationController
  before_action :set_character

  # GET /characters/:id/events
  def index
    events = @character_instance.events
    json_response(
      events.map { |event| Character::ApiPresenter::Event.format(event) }
    )
  end

  private

  def set_character
    @character_instance = Character::Instance.find(params[:character_id])
    raise ForbiddenError, "You can't edit an other user's characters" if @character_instance.user != current_user
  end
end
