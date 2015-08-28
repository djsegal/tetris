# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  number_of_players :integer
#

class Game < ActiveRecord::Base

  has_many :players

  after_create :make_players

  private

    def make_players
      number_of_players.times do |i|
        players.create! ordering_index: i
      end
    end

end
