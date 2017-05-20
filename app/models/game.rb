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

class Game < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'
  belongs_to :team

  has_many :user_attendances, dependent: :destroy
  has_many :players, through: :user_attendances, source: :user

  enum status: [:pending, :canceled, :completed]
  after_initialize :set_default_status, if: :new_record?

  validates :name, :status, :time, :location, presence: true

  after_create do
    team.users.each do |user|
      self.user_attendances.create!(team: team, user: user)
    end
  end

  def set_default_status
    self.status ||= :pending
  end

  def created_by?(user)
    return false unless user.is_a? User
    created_by == user
  end
end
