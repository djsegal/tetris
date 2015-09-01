# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  number_of_players :integer
#  mode              :string
#  name              :string
#  slug              :string
#

class Game < ActiveRecord::Base

  has_many :players

  after_create :make_players
  before_create :make_name

  include FriendlyId
  friendly_id :name, use: :slugged

  private

    def make_players
      number_of_players.times do |i|
        players.create! ordering_index: i
      end
    end

    def make_name
      return if name.present?
      self.name = SecureRandom.uuid
      while Game.exists? name: name
        self.name = SecureRandom.uuid
      end
    end

end
