# == Schema Information
#
# Table name: user_attendances
#
#  id                 :integer          not null, primary key
#  team_attendance_id :integer
#  user_id            :integer
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_user_attendances_on_team_attendance_id  (team_attendance_id)
#  index_user_attendances_on_user_id             (user_id)
#

FactoryGirl.define do
  factory :user_attendance do
    team_attendance nil
    user nil
    status 1
  end
end
