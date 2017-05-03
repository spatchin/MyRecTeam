# == Schema Information
#
# Table name: team_attendances
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  team_id    :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_team_attendances_on_game_id  (game_id)
#  index_team_attendances_on_team_id  (team_id)
#

# attendance record for a given team for a given game
class TeamAttendance < ApplicationRecord
  belongs_to :game
  belongs_to :team

  has_many :user_attendences
  has_many :players, through: :user_attendences, class_name: 'User'

  enum status: [:upcoming, :inprogress, :complete]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.status ||= :upcoming
  end

  # TODO test this
  def attended_players
    players.joins(:user_attendences).where(user_attendence: [status: :attended])
  end
end
