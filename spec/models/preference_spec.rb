# == Schema Information
#
# Table name: preferences
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  game_email_reminder :time             default(2000-01-01 14:00:00 UTC)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_preferences_on_user_id  (user_id)
#

describe Member do
  let!(:preference) { create(:preference) }

  subject { preference }

  it { should belong_to(:user) }
end

