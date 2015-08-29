class AddOrderingIndexToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :ordering_index, :integer
  end
end
