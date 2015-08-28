class AddPiecePreviewRefToPieces < ActiveRecord::Migration
  def change
    add_reference :pieces, :piece_preview, index: true, foreign_key: true
  end
end
