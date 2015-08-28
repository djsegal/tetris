# == Schema Information
#
# Table name: pieces
#
#  id         :integer          not null, primary key
#  grid_id    :integer
#  x_pos      :integer
#  y_pos      :integer
#  type       :string
#  color      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Piece < ActiveRecord::Base
  belongs_to :grid
end
