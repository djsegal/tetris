class AddCurrentPieceRefToPieces < ActiveRecord::Migration
  def change
    add_reference :pieces, :current_piece, index: true, foreign_key: true
  end
end
