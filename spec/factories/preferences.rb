# == Schema Information
#
# Table name: preferences
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  game_email_reminder :time             default(Sat, 01 Jan 2000 14:00:00 UTC +00:00)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_preferences_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :preference do
    user

    game_email_reminder { Time.now }
  end
end
