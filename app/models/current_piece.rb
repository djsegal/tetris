# == Schema Information
#
# Table name: current_pieces
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CurrentPiece < ActiveRecord::Base

  belongs_to :player

  has_one :piece

  has_one :piece_preview, through: :player

  after_create :make_initial_current_piece

  private

    def make_initial_current_piece
      next_piece = piece_preview.pieces.first
      next_piece.piece_preview = nil
      next_piece.current_piece = self
      next_piece.save!
    end

end
