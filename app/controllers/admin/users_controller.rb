class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10) # ページごとに10件表示
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts # ユーザーの投稿を取得
  end
end
