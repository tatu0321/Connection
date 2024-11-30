class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre, only: [:edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルが作成されました"
    else
      flash.now[:alert] = "ジャンルの作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルが更新されました。"
    else
      flash.now[:alert] = "ジャンルの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @genre.destroy
      redirect_to admin_genres_path, notice: "ジャンルが削除されました。"
    else
      redirect_to admin_genres_path, alert: "ジャンルの削除に失敗しました。"
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
