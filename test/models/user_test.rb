# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  score          :integer
#  game_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ordering_index :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
