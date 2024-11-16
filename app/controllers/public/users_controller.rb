class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    # マイページの場合
    if params[:id].nil?
      @user = current_user
      @is_current_user = true
    else
    # 他人のプロフィール詳細の場合
      @user = User.find(params[:id])
      @is_current_user = current_user == @user
    end
    @posts = @user.posts
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
