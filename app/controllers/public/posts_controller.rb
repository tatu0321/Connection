class Public::PostsController < ApplicationController
  before_action :authenticate_user!

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
    # @posts = Post.all.order(created_at: :desc)
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id]) # 投稿をIDで取得
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました。"
      redirect_to posts_path
    else
      flash[:alert] = "投稿の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  #現在のユーザーが投稿者であるか確認
  def correct_user
    unless @post.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to posts_path
    end
  end
end
