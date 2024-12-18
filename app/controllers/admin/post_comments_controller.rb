class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    post = Post.find(params[:post_id])
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_back fallback_location: admin_posts_path, notice: 'コメントを削除しました。'
  end
end
