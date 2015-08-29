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
#

require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
