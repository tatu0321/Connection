class AddColorToGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :genres, :color, :string
  end
end
