class CreatePermutations < ActiveRecord::Migration
  def change
    create_table :permutations do |t|
      t.references :piece, index: true, foreign_key: true
      t.integer :ordering_index

      t.timestamps null: false
    end
  end
end
