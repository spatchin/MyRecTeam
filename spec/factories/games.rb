# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  time       :datetime
#  location   :string
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :game do
    name "MyString"
    time "2017-04-28 18:30:29"
    location "MyString"
    notes "MyText"
  end
end
