class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.following << user
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:id])
    current_user.following.delete(user)
    redirect_to request.referer
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers
  end

  def following
    @user = User.find(params[:user_id])
    @following = @user.following
  end
end
