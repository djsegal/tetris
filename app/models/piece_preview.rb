# == Schema Information
#
# Table name: piece_previews
#
#  id            :integer          not null, primary key
#  visible_count :integer          default(3)
#  player_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PiecePreview < ActiveRecord::Base

  belongs_to :player

  has_one :grid, through: :player

  has_many :pieces

  after_create :make_initial_batch

  def make_batch_of_pieces
    number_of_pieces_in_play = grid.pieces.count + pieces.count
    piece_bag = Piece.possible_pieces
    number_of_pieces_in_bag = piece_bag.count

    number_of_pieces_in_bag.times do |i|
      current_index = rand( number_of_pieces_in_bag - i )
      current_piece = piece_bag.delete_at current_index
      current_piece[:ordering_index] = i + number_of_pieces_in_play
      pieces.build current_piece
    end
    save!
  end

  private

    def make_initial_batch
      make_batch_of_pieces
      pieces.each do |piece|
        break if Piece::TYPES_OF_FIRST_PIECES.include? piece.piece_type
        pieces.destroy piece
      end
      make_batch_of_pieces
    end

end
