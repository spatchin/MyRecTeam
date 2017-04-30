# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  time       :datetime
#  location   :string
#  notes      :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_games_on_user_id  (user_id)
#

class Game < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
  validates :name, uniqueness: true

end
