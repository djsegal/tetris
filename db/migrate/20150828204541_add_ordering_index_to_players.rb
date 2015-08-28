class AddOrderingIndexToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :ordering_index, :integer
  end
end
