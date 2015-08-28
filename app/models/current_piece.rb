# == Schema Information
#
# Table name: current_pieces
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CurrentPiece < ActiveRecord::Base

  belongs_to :player

  has_one :piece

end
