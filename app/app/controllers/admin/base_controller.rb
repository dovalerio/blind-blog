module Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin

    private

    def authenticate_admin
      authenticate_or_request_with_http_basic("Terra de Cego — Admin") do |user, password|
        ActiveSupport::SecurityUtils.secure_compare(user, ENV.fetch("ADMIN_USER", "admin")) &
          ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch("ADMIN_PASSWORD", ""))
      end
    end
  end
end
