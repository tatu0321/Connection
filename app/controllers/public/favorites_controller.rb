class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.create(post: @post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def index
    # ログインユーザーがいいねした投稿を取得
    @favorite_posts = current_user.favorites.includes(:post).map(&:post)
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @post = @favorite.post
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
end
