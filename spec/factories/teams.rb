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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :team do
    created_by

    name { Faker::Book.unique.title }
    wins { rand(1..10) }
    losses { rand(1..10) }
    draws { rand(1..10) }
    location { ['Madison, WI', 'Verona, WI'].sample }
  
    trait :with_members do
      after(:create) do |prof, eval|
        prof.members << create(:member, role: :captain, team: prof)
        5.times { prof.members << create(:member, role: :starter, team: prof) }
        3.times { prof.members << create(:member, role: :alternate, team: prof) }
      end
    end
  end
end
