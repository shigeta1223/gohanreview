class Admin::UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    if @user.deleted_at.nil?
      @user.update(deleted_at: Time.current)
      redirect_to admin_users_path, notice: "ユーザーを退会させました"
    else
      redirect_to admin_users_path, alert: "このユーザーはすでに退会済みです"
    end
  end
end
