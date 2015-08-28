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

require 'test_helper'

class PiecePreviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
