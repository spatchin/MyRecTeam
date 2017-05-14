# == Schema Information
#
# Table name: user_attendances
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  team_id    :integer
#  user_id    :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_attendances_on_game_id  (game_id)
#  index_user_attendances_on_team_id  (team_id)
#  index_user_attendances_on_user_id  (user_id)
#

describe UserAttendance do
  let!(:user_attendance) { create(:user_attendance) }

  subject { user_attendance }

  it { should belong_to(:game) }
  it { should belong_to(:team) }
  it { should belong_to(:user) }

  it { should define_enum_for(:status) }

  it { should validate_presence_of(:status) }
end
