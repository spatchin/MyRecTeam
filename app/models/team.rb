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
  has_many :starting_members, -> { where(role: 'starter') }, class_name: 'Member'
  has_many :alternate_members, -> { where(role: 'alternate') }, class_name: 'Member'
  has_many :users, through: :members
  has_many :starters, through: :starting_members, source: :user
  has_many :alternates, through: :alternate_members, source: :user

  has_many :games, dependent: :destroy
  has_many :attendance_records, class_name: 'UserAttendance', dependent: :destroy

  validates :name, :location, presence: true
  validates :name, uniqueness: true

  # ids of all releavant peopel to this team
  def all_member_ids
    Users.where(id: members.pluck(:user_id)).distinct.ids
  end

  def created_by?(user)
    user.is_a?(User) && created_by == user
  end

  def captain?(user)
    user.is_a?(User) && captain == user
  end

  def invited_user?(user)
    user.is_a?(User) && members.exists?(['members.user_id = ? AND members.token IS NOT NULL', user.id])
  end
end
