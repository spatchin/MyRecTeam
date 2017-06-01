# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  team_id     :integer
#  role        :integer
#  invited_at  :datetime
#  accepted_at :datetime
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_members_on_team_id  (team_id)
#  index_members_on_user_id  (user_id)
#

describe Member do
  let!(:member) { create(:member) }

  subject { member }

  it { should belong_to(:user) }
  it { should belong_to(:team) }

  it { should define_enum_for(:role) }

  it { should validate_presence_of(:role) }
end
