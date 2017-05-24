# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  time       :datetime
#  location   :string
#  notes      :text
#  status     :integer
#  user_id    :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_games_on_team_id  (team_id)
#  index_games_on_user_id  (user_id)
#

describe Game do
  context 'model' do
    let!(:game) { create(:game) }

    subject { game }

    it { should belong_to(:created_by).class_name('User').with_foreign_key('user_id') }

    it { should have_many(:user_attendances).dependent(:destroy) }
    it { should have_many(:players).through(:user_attendances) }

    it { should define_enum_for(:status) }

    it { should validate_presence_of(:name) }
  end

  context 'create' do
    it 'should send email reminders to players of team' do
      team = create(:team)
      game = create(:game)

    end
  end
end
