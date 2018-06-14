class HealthController < ActionController::API
  include Response

  def index
    json_response({})
  end
end
