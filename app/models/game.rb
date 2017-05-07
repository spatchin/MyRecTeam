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
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_games_on_user_id  (user_id)
#

class Game < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'

  has_many :team_attendances, dependent: :destroy
  has_many :teams, through: :team_attendances
  
  enum status: [:pending, :in_progress, :complete]
  after_initialize :set_default_status, if: :new_record?

  validates :name, :status, presence: true

  def set_default_status
    self.status ||= :pending
  end

  def is_player?(user)
    return false unless user.is_a? User
    team_attendances.players.include?(user)
  end

  def created_by?(user)
    return false unless user.is_a? User
    created_by == user
  end
end
