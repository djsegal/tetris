class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.references :grid, index: true, foreign_key: true
      t.integer :x_pos
      t.integer :y_pos
      t.string :type
      t.string :color

      t.timestamps null: false
    end
  end
end
