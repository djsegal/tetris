class AddModeToGames < ActiveRecord::Migration
  def change
    add_column :games, :mode, :string
  end
end
