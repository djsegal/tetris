# == Schema Information
#
# Table name: blocks
#
#  id             :integer          not null, primary key
#  permutation_id :integer
#  x_pos          :integer
#  y_pos          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Block < ActiveRecord::Base
  belongs_to :permutation
end
