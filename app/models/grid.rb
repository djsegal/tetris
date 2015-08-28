# == Schema Information
#
# Table name: grids
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grid < ActiveRecord::Base
  belongs_to :player
end
