class Admin::PostsController < ApplicationController
  before_action :authenticate_admin! # 管理者認証を適用

  def index
    @posts = Post.all
    @genres = Genre.all
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

  def search
    @genres = Genre.all
    if params[:genre_ids].present?
      @posts = Post.where(genre_id: params[:genre_ids]).order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    render :index
  end
end
