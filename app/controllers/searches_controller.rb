class SearchesController < ApplicationController

  def index
    if user_signed_in? || admin_signed_in?
      query = params[:q]
      if query.present?
        @users = User.where('name LIKE ?', "%#{query}%")
        @posts = Post.where('content LIKE ?', "%#{query}%")
      else
        @users = []
        @posts = []
      end
    else
      redirect_to root_path
    end
  end
end
