# app/controllers/admin/genres_controller.rb
class Admin::GenresController < ApplicationController
  before_action :set_genre, only: %i[show edit update destroy]

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: 'ジャンルが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'ジャンルが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @genre.destroy
    redirect_to admin_genres_path, notice: 'ジャンルが削除されました。'
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :color)
  end
end
