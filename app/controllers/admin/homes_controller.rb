# app/controllers/admin/homes_controller.rb
module Admin
  class HomesController < ApplicationController
    before_action :authenticate_admin_user!

    def top
    end
  end
end
