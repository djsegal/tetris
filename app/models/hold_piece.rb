# == Schema Information
#
# Table name: hold_pieces
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HoldPiece < ActiveRecord::Base

  belongs_to :player

  has_one :piece

  has_one :current_piece, through: :player

  has_one :piece_preview, through: :player

  def hold_current_piece
    if piece.nil?
      next_held_piece = current_piece.piece
      self.piece = next_held_piece
      current_piece.get_next_piece
    else
      work_piece = piece
      self.piece = current_piece.piece
      current_piece.piece = work_piece
    end
  end

end
