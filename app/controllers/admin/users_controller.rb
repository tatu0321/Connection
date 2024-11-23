class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10) # ページごとに10件表示
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts # ユーザーの投稿を取得
  end

  def destroy
    user = User.find(params[:id])
    user.posts.destroy_all # ユーザーの投稿を全て削除
    user.post_comments.destroy_all # ユーザーのコメントを全て削除
    user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
  end
end
