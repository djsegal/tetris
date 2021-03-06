class AddNameToGames < ActiveRecord::Migration
  def change
    add_column :games, :name, :string
    add_column :games, :slug, :string
    add_index :games, :slug, unique: true
  end
end
