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

class PiecePreview < ActiveRecord::Base

  belongs_to :player

  has_one :grid, through: :player

  has_many :pieces

end
