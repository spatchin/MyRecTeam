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

FactoryGirl.define do
  factory :game do
    created_by
    team

    name { FFaker::Sport.name }
    time { FFaker::Time.datetime }
    location { ['Madison, WI', 'Verona, WI'].sample }
    notes { FFaker::Lorem.paragraph }

    trait :canceled do
      status 'canceled'
    end

    trait :win do
      status 'win'
    end

    trait :draw do
      status 'draw'
    end

    trait :loss do
      status 'loss'
    end
  end
end
