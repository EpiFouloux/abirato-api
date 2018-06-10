# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from StandardError do |e|
      # TODO: Add Bugsnag.notify(e) here
      json_response({message: e.message}, :error)
    end

    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found

    rescue_from ActionController::RoutingError, with: :error_not_found

    rescue_from ActiveRecord::RecordInvalid, with: :error_unprocessable

    rescue_from ActionController::ParameterMissing, with: :error_unprocessable

    rescue_from ActiveModel::ForbiddenAttributesError do |e|
      json_response({ message: e.message }, :bad_request)
    end

    rescue_from ExceptionHandler::AuthenticationError do |e|
      json_response({ message: e.message }, :unauthorized)
    end
    rescue_from ExceptionHandler::MissingToken, with: :error_unprocessable

    rescue_from ExceptionHandler::InvalidToken, with: :error_unprocessable
  end

  private

  def error_not_found(exception)
    json_response({ message: exception.message }, :not_found)
  end

  def error_unprocessable(exception)
    json_response({ message: exception.message }, :unprocessable_entity)
  end
end