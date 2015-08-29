class AddSideBufferToGrids < ActiveRecord::Migration
  def change
    add_column :grids, :side_buffer, :integer, default: 2
  end
end
