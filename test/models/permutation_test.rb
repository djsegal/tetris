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

require 'test_helper'

class PermutationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
