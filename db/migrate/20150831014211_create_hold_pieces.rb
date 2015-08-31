class CreateHoldPieces < ActiveRecord::Migration
  def change
    create_table :hold_pieces do |t|
      t.references :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
