# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  wins       :integer
#  losses     :integer
#  draws      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :team do
    name "MyString"
    wins 1
    losses 1
    draws 1
  end
end
