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

FactoryGirl.define do
  factory :team do
    created_by
    captain
    
    name { Faker::Book.unique.title }
    wins { rand(1..10) }
    losses { rand(1..10) }
    draws { rand(1..10) }
    location { ['Madison, WI', 'Verona, WI'].sample }
  end
end
