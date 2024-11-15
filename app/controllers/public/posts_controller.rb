class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿が作成されました。"
    else
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id]) # 投稿をIDで取得
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
