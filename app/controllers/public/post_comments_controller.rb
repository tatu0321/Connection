class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user! # ログイン必須
  before_action :correct_user, only: [:edit, :update, :destroy] # 権限チェック

  def create
    @post = Post.find(params[:post_id]) # コメント対象の投稿を取得
    @comment = @post.post_comments.build(comment_params) # 投稿に紐付け
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "コメントを投稿しました。"
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      redirect_to post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "コメントが更新されました。"
    else
      flash.now[:alert] = "コメントの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = "コメントを削除しました。"
    else
      flash[:alert] = "コメントの削除権限がありません。"
    end
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content)
  end

  def correct_user
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.find(params[:id])
    unless @comment.user == current_user
      flash[:alert] = "権限がありません"
      redirect_to post_path(@post)
    end
  end
end
