class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :ensure_guest_user, only: [:edit, :update]

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

  def destroy
    if current_user.destroy  # 現在のユーザーを削除
      flash[:notice] = "アカウントを削除しました。ご利用ありがとうございました。"
      redirect_to about_path
    else
      flash[:alert] = "アカウントの削除に失敗しました。"
      redirect_to mypage_path
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar, :email)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へアクセスできません。"
    end
  end  
end
