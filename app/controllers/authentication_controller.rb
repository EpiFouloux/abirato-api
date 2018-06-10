# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth = AuthenticateUser.new(auth_params[:email], auth_params[:password])
    auth_token = auth.call
    json_response(
      auth_token: auth_token,
      user_id: auth.user.id
    )
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
