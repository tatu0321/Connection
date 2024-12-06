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
    @genres = Genre.all # ジャンルを取得
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

  def search
    @genres = Genre.all
    # 現在のユーザーがいいねした投稿を取得
    favorite_posts = current_user.favorites.includes(:post).map(&:post)
    if params[:genre_ids].present?
      # いいねした投稿の中から、選択されたジャンルに該当する投稿を絞り込む
      @favorite_posts = favorite_posts.select { |post| params[:genre_ids].include?(post.genre_id.to_s) }
    else
      # すべてのいいねした投稿を表示
      @favorite_posts = favorite_posts
    end
    render :index
  end
end
