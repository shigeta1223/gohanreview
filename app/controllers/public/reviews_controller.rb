class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :tag_search]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.includes(:user).order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
    @comments = @review.comments.includes(:user)
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      @review.tag_list = review_params[:tag_list]
      @review.save
      redirect_to @review, notice: "レビューを投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      @review.tag_list = review_params[:tag_list]
      @review.save
      redirect_to @review, notice: "レビューを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: "レビューを削除しました。"
  end

  def search
    keyword = params[:keyword].to_s.strip
    if keyword.present?
      @reviews = Review.includes(:user)
                       .where("title LIKE :kw OR body LIKE :kw", kw: "%#{keyword}%")
                       .order(created_at: :desc)
    else
      @reviews = Review.none
    end
    render :index
  end

  def tag_search
    @reviews = Review.joins(:tags).where(tags: { name: params[:tag_name] })
    render :index
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def authorize_user!
    redirect_to reviews_path, alert: "権限がありません。" unless @review.user == current_user
  end

  def review_params
    params.require(:review).permit(:title, :body, :image, :tag_list)
  end
end
