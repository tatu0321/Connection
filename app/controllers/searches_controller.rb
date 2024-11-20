class SearchesController < ApplicationController

  def index
    query = params[:q]
    if query.present?
      @users = User.where('name LIKE ?', "%#{query}%")
      @posts = Post.where('content LIKE ?', "%#{query}%")
    else
      @users = []
      @posts = []
    end
  end
end
