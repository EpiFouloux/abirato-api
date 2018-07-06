require_relative 'api_presenter/user'

class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy update]
  before_action :check_user, only: %i[update destroy]
  skip_before_action :authorize_request, only: %i[create index show]

  # GET /users
  def index
    users = User.all
    json_response(
        users.map { |u| ApiPresenter::User.format(u) }
    )
  end

  # GET /users/:id
  def show
    json_response(ApiPresenter::User.format(@user))
  end

  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.name, user.password).call
    response = {
        message: Message.account_created,
        auth_token: auth_token,
        user_id: user.id
    }
    json_response(response, :created)
  end

  # PUT /users/:id
  def update
    parameters = params.permit(:name, :email)
    raise ActionController::ParameterMissing, "No allowed parameters provided" if parameters.blank?
    @user.assign_attributes(parameters)
    @user.save!
    json_response(ApiPresenter::User.format(@user))
  end

  # DELETE /users/:id
  def destroy
    @user.destroy!
    head :no_content
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    raise ForbiddenError, "You can't edit an other user's characters" if @user != current_user
  end
end
