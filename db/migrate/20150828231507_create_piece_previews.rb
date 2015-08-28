class CreatePiecePreviews < ActiveRecord::Migration
  def change
    create_table :piece_previews do |t|
      t.integer :visible_count, default: 3
      t.references :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
