class FleshOutGrids < ActiveRecord::Migration
  def up
    # Set default values
    change_column_default :grids, :width, 10
    change_column_default :grids, :height, 20
    add_column :grids, :top_buffer, :integer, default: 2
    add_column :grids, :bot_buffer, :integer, default: 3
  end

  def down
    # Remove default values
    change_column_default :grids, :width, nil
    change_column_default :grids, :height, nil
    remove_columns :grids, :top_buffer, :bot_buffer
  end
end
