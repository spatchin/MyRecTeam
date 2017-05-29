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
#  captain_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_teams_on_captain_id  (captain_id)
#  index_teams_on_user_id     (user_id)
#

describe Team do
  context 'model' do
    let!(:team) { create(:team) }

    subject { team }

    it { should belong_to(:created_by).class_name('User') }
    it { should belong_to(:captain).class_name('User') }

    it { should have_many(:members).dependent(:destroy) }
    it { should have_many(:starting_members) }
    it { should have_many(:alternate_members) }
    it { should have_many(:starters).through(:starting_members).source(:user) }
    it { should have_many(:alternates).through(:alternate_members).source(:user) }

    it { should have_many(:games).dependent(:destroy) }
    it { should have_many(:attendance_records).class_name('UserAttendance').dependent(:destroy) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }

    it { should validate_uniqueness_of(:name) }
  end
end
