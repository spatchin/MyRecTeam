# == Schema Information
#
# Table name: user_attendances
#
#  id                 :integer          not null, primary key
#  team_attendance_id :integer
#  user_id            :integer
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_user_attendances_on_team_attendance_id  (team_attendance_id)
#  index_user_attendances_on_user_id             (user_id)
#

# attendance record for a given user on a given team for a given game
class UserAttendance < ApplicationRecord
  belongs_to :team_attendance
  belongs_to :user

  enum status: [:unreported, :absent, :attended]
  after_initialize :set_default_status, if: :new_record?

  validates :status, presence: true

  def set_default_status
    self.status ||= :unreported
  end
end
