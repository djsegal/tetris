class AddWidthToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :width, :integer, default: 3
  end
end
