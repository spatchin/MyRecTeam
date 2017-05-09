# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  username               :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default(0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invitations_count     (invitations_count)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

describe User do
  let!(:user) { create(:user) }

  subject { user }

  it { should have_many(:created_games).class_name('Game') }
  it { should have_many(:created_teams).class_name('Team') }
  it { should have_many(:captained_teams).class_name('Team').with_foreign_key('captain_id') }

  it { should have_many(:members).dependent(:destroy) }
  it { should have_many(:starting_members) }
  it { should have_many(:alternate_members) }
  it { should have_many(:starting_teams).through(:starting_members).source(:team) }
  it { should have_many(:alternate_teams).through(:alternate_members).source(:team) }

  it { should have_many(:attendance_records).class_name('UserAttendance').dependent(:destroy) }
  it { should have_many(:team_attendance_records).through(:attendance_records).class_name('TeamAttendance') }

  it { should define_enum_for(:role) }

  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }

  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:username) }
end
