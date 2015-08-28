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

  has_many :users

  after_create :make_users

  private

    def make_users
      number_of_players.times do |i|
        users.create!
      end
      binding.pry
    end

end
