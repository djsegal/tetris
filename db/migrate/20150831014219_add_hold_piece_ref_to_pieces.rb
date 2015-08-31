class AddHoldPieceRefToPieces < ActiveRecord::Migration
  def change
    add_reference :pieces, :hold_piece, index: true, foreign_key: true
  end
end
