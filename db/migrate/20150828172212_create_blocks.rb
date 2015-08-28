class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :permutation, index: true, foreign_key: true
      t.integer :x_pos
      t.integer :y_pos

      t.timestamps null: false
    end
  end
end
