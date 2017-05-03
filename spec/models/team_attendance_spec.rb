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

describe TeamAttendance do
  let!(:team_attendance) { create(:team_attendance) }

  subject { team_attendance }

  it { should belong_to(:game) }
  it { should belong_to(:team) }

  it { should have_many(:user_attendances) }
  it { should have_many(:players) }

  it { should define_enum_for(:status) }

  it { should validate_presence_of(:status) }
end
