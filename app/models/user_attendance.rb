# == Schema Information
#
# Table name: user_attendances
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  team_id    :integer
#  user_id    :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_attendances_on_game_id  (game_id)
#  index_user_attendances_on_team_id  (team_id)
#  index_user_attendances_on_user_id  (user_id)
#

class UserAttendance < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :user

  enum status: [:unreported, :absent, :attending]
  after_initialize :set_default_status, if: :new_record?

  validates :status, presence: true

  def set_default_status
    self.status ||= :unreported
  end
end
