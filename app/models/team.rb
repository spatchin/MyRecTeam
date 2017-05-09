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

class Team < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'
  belongs_to :captain, class_name: 'User'

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :starting_members, -> { where(role: 'starter') }, class_name: 'Member'
  has_many :alternate_members, -> { where(role: 'alternate') }, class_name: 'Member'
  has_many :starters, through: :starting_members, source: :user
  has_many :alternates, through: :alternate_members, source: :user
  # has_many :users, through: :members

  has_many :team_attendances
  has_many :games, through: :team_attendances

  validates :name, :location, presence: true
  validates :name, uniqueness: true
 
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

  def captain?(user)
    return false unless user.is_a? User
    captain == user
  end

  def players
    User.where(id: users.ids << captain_id).order(:first_name)
  end
end
