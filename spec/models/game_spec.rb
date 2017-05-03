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

describe Game do
  let!(:game) { create(:game) }

  subject { game }

  it { should belong_to(:created_by) }

  it { should have_many(:team_attendances) }
  it { should have_many(:teams) }

  it { should validate_presence_of(:name) }
end
