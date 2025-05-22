module Public
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_review

    def create
      @comment = @review.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to review_path(@review), notice: "コメントを投稿しました。"
      else
        redirect_to review_path(@review), alert: "コメントの投稿に失敗しました。"
      end
    end

    def destroy
      @comment = @review.comments.find(params[:id])
      if @comment.user == current_user
        @comment.destroy
        redirect_to review_path(@review), notice: "コメントを削除しました。"
      else
        redirect_to review_path(@review), alert: "削除権限がありません。"
      end
    end

    private

    def set_review
      @review = Review.find(params[:review_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
