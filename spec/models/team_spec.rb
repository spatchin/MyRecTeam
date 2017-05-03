# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  location    :string
#  wins        :integer
#  losses      :integer
#  draws       :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#

describe Team do
  let!(:team) { create(:team) }

  subject { team }

  it { should belong_to(:created_by) }

  it { should have_many(:members) }
  it { should have_many(:users) }
  it { should have_many(:team_attendances) }
  it { should have_many(:games) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }

  it { should validate_uniqueness_of(:name) }
end
