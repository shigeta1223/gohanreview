class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :confirm, :withdraw]
  before_action :ensure_correct_user, only: [:edit, :update, :confirm, :withdraw]

  def index
    if params[:keyword].present?
      @users = User.active.where("name LIKE ?", "%#{params[:keyword]}%")
    else
      @users = User.active
    end
  end

  def show
    @reviews = @user.reviews.order(created_at: :desc)
  end

  def edit
    # 処理は before_action に移動済み
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def confirm
    # 処理は before_action に移動済み
  end

  def withdraw
    @user.update(deleted_at: Time.current)
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました"
  end

  def search
    redirect_to users_path(keyword: params[:keyword])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to root_path, alert: "権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
