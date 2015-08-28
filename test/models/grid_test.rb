# == Schema Information
#
# Table name: grids
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GridTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
