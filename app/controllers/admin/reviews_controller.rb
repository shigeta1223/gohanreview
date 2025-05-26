# app/controllers/admin/reviews_controller.rb
module Admin
  class ReviewsController < ApplicationController
    before_action :authenticate_admin_user!

    def index
      @reviews = Review.includes(:user).order(created_at: :desc)
    end

    def destroy
      review = Review.find(params[:id])
      review.destroy
      redirect_to admin_reviews_path, notice: "レビューを削除しました"
    end
  end
end
