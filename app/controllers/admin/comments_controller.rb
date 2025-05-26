module Admin
  class CommentsController < ApplicationController
    before_action :authenticate_admin_user!

    def index
      @comments = Comment.includes(:user, :review).order(created_at: :desc)
    end

    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      redirect_to admin_comments_path, notice: "コメントを削除しました。"
    end
  end
end
