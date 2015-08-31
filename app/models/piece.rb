# == Schema Information
#
# Table name: pieces
#
#  id               :integer          not null, primary key
#  grid_id          :integer
#  x_pos            :integer
#  y_pos            :integer
#  piece_type       :string
#  color            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  piece_preview_id :integer
#  current_piece_id :integer
#  ordering_index   :integer
#  width            :integer          default(3)
#  hold_piece_id    :integer
#

class Piece < ActiveRecord::Base

  default_scope { order('ordering_index ASC') }

  belongs_to :piece_preview

  belongs_to :current_piece

  belongs_to :hold_piece

  belongs_to :grid

  has_many :permutations

  TYPES_OF_FIRST_PIECES = [ 'i', 't', 'j', 'l' ]

  before_create :make_initial_permutation

  # --------------------
  #  instance variables
  # --------------------

  # -----------------
  #  class variables
  # -----------------

  def self.possible_pieces
    large_pieces + small_pieces + medium_pieces
  end

  def self.large_pieces
    [ { piece_type: 'i', color: 'cyan', width: 4 } ]
  end

  def self.small_pieces
    [ { piece_type: 'o', color: 'gold', width: 2 } ]
  end

  def self.medium_pieces
    [
      { piece_type: 't', color: 'purple' },
      { piece_type: 's', color: 'green'  },
      { piece_type: 'z', color: 'red'    },
      { piece_type: 'j', color: 'blue'   },
      { piece_type: 'l', color: 'orange' },
    ]
  end

  private

    def make_initial_permutation
      permutations.build ordering_index: 0
    end

end
