class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿が作成されました。"
    else
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    # 投稿は `set_post` により取得済み
  end

  def edit
    # 投稿は `set_post` により取得済み
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "投稿の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "投稿が見つかりません。"
    redirect_to posts_path
  end

  # 現在のユーザーが投稿者であるか確認
  def correct_user
    unless @post.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to posts_path
    end
  end
end
