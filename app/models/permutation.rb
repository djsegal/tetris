# == Schema Information
#
# Table name: permutations
#
#  id             :integer          not null, primary key
#  piece_id       :integer
#  ordering_index :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Permutation < ActiveRecord::Base

  belongs_to :piece

  has_many :blocks

  before_create :make_initial_blocks

  # ------------------
  #  instance methods
  # ------------------

  def init_i_piece
    y_pos = 2
    4.times do |i|
      blocks.build x_pos: i, y_pos: y_pos
    end
  end

  def init_o_piece
    2.times do |i|
      2.times do |j|
        blocks.build x_pos: i, y_pos: j
      end
    end
  end

  def init_j_piece
    3.times do |i|
      blocks.build x_pos: i, y_pos: 1
    end
    blocks.build   x_pos: 0, y_pos: 2
  end

  def init_t_piece
    3.times do |i|
      blocks.build x_pos: i, y_pos: 1
    end
    blocks.build   x_pos: 1, y_pos: 2
  end

  def init_l_piece
    3.times do |i|
      blocks.build x_pos: i, y_pos: 1
    end
    blocks.build   x_pos: 2, y_pos: 2
  end

  def init_s_piece
    2.times do |i|
      2.times do |j|
        blocks.build x_pos: i+1, y_pos: (i+j+0)%2
      end
    end
  end

  def init_z_piece
    2.times do |i|
      2.times do |j|
        blocks.build x_pos: i+1, y_pos: (i+j+1)%2
      end
    end
  end

  private

    def make_initial_blocks
      return unless ordering_index.zero?
      case piece.piece_type
      when 'i' ; init_i_piece
      when 'o' ; init_o_piece
      when 't' ; init_t_piece
      when 's' ; init_s_piece
      when 'z' ; init_z_piece
      when 'j' ; init_j_piece
      when 'l' ; init_i_piece
      else
        _raise 'Bad piece type for permutation.'
      end
    end

end
