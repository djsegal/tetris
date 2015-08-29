# == Schema Information
#
# Table name: permutations
#
#  id             :integer          not null, primary key
#  piece_id       :integer
#  ordering_index :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Permutation < ActiveRecord::Base

  belongs_to :piece

  has_many :blocks

end
