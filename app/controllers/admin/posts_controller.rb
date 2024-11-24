class Admin::PostsController < ApplicationController
  before_action :authenticate_admin! # 管理者認証を適用

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user # 投稿者情報を取得
    @comments = @post.post_comments.includes(:user) # コメントも取得
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end
end
