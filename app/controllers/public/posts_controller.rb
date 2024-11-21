class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿が作成されました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @posts = Post.includes(:user, :post_comments).order(created_at: :desc)
  end

  def show
    @comments = @post.post_comments.includes(:user) # 投稿に紐付いたコメント一覧
    @comment = PostComment.new # 新規コメント用
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿を更新しました。"
    else
      flash.now[:alert] = "投稿の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
    else
      flash[:alert] = "投稿の削除に失敗しました。"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    unless @post.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to posts_path
    end
  end

  def handle_record_not_found
    flash[:alert] = "投稿が見つかりません。"
    redirect_to posts_path
  end
end

