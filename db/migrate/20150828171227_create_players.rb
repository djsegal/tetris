class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :score
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
