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

  has_one :grid, through: :player

  after_create :make_initial_current_piece

  def position_piece
    x_pos  = (  grid.width / 2      )
    x_pos -= ( piece.width / 2.to_f ).ceil

    y_pos  = grid.height
    y_pos -= piece.permutations.first.blocks.minimum(:y_pos)

    piece.update_attributes x_pos: x_pos, y_pos: y_pos
  end

  private

    def make_initial_current_piece
      next_piece = piece_preview.pieces.first
      next_piece.piece_preview = nil
      next_piece.current_piece = self
      next_piece.save!
      position_piece
    end

end
