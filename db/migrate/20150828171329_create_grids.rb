class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :height
      t.integer :width

      t.timestamps null: false
    end
  end
end
