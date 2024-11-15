class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    # ここでユーザーの投稿などの情報も取得可能です
    @posts = @user.posts # ユーザーが投稿を持っている場合
  end
end
