# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  team_id     :integer
#  role        :integer
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

FactoryGirl.define do
  factory :member do
    user
    team

    role { Member.roles.values.sample }
  end
end
