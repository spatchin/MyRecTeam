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

class Team < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'

  has_many :members
  has_many :users, through: :members

  has_many :team_attendances
  has_many :games, through: :team_attendances

  validates :name, :location, presence: true
  validates :name, uniqueness: true
 
  def captain
    members.find_by(role: :captain).try(:user)
  end

  def starters
    User.where(id: members.where(role: :starter).pluck(:user_id))
  end

  def alternates
    User.where(id: members.where(role: :alternate).pluck(:user_id))
  end

  # ids of all releavant peopel to this team
  def all_member_ids
    members.ids.compact.uniq
  end

  # check if user is a key person 
  def is_key_person?(user)
    return false unless user.is_a? User
    (members.where(role: :captain).ids + [user_id]).include?(user)
  end

  def created_by?(user)
    return false unless user.is_a? User
    created_by == user
  end  
end
