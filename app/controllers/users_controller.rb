class UsersController < ApplicationController

  # GET /users
  def index
    json_response(User.all)
  end

  # GET /users/:id
  def show

  end

  # POST /users
  def create

  end

  # PUT /users/:id
  def update

  end

  # DELETE /users/:id
  def destroy

  end
end
