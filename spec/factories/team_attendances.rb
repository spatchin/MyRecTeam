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

FactoryGirl.define do
  factory :team_attendance do
    game 
    team 

    status { TeamAttendance.statuses.values.sample }
  end
end
