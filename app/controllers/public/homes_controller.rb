class Public::HomesController < ApplicationController
  def top
     # ログインしている場合はマイページにリダイレクト
     redirect_to mypage_path if user_signed_in?
  end

  def about
  end
end
