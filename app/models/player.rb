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

  default_scope { order('ordering_index ASC') }

  belongs_to :game

  has_one :grid

  before_create :setup_player_components

  private

    def setup_player_components
      build_grid
    end

end
