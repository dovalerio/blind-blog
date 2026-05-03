module Api
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    before_action :authenticate_api

    private

    def authenticate_api
      token = request.headers["Authorization"]&.delete_prefix("Bearer ")
      unless token && ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch("API_TOKEN", ""))
        render json: { error: "Não autorizado" }, status: :unauthorized
      end
    end
  end
end
