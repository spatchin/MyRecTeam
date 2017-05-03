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

FactoryGirl.define do
  factory :game do
    created_by

    name { FFaker::Sport.name } 
    time { FFaker::Time.datetime }
    location { ['Madison, WI', 'Verona, WI'].sample }
    notes { FFaker::Lorem.paragraph }
  end
end
