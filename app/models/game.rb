# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  time       :datetime
#  location   :string
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord
end
