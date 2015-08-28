# == Schema Information
#
# Table name: players
#
#  id             :integer          not null, primary key
#  score          :integer
#  game_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ordering_index :integer
#

class Player < ActiveRecord::Base
  belongs_to :game
end
