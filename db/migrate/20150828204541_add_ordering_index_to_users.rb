class AddOrderingIndexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ordering_index, :integer
  end
end
