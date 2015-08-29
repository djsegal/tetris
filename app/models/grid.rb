# == Schema Information
#
# Table name: grids
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  height      :integer          default(20)
#  width       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  top_buffer  :integer          default(2)
#  bot_buffer  :integer          default(3)
#  side_buffer :integer          default(2)
#

class Grid < ActiveRecord::Base

  belongs_to :player

  has_many :pieces

end
