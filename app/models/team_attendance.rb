class TeamAttendance < ApplicationRecord
  belongs_to :game
  belongs_to :team

  has_many :user_attendences
  has_many :players, through: :user_attendences, class_name: 'User'

  enum role: [:upcoming, :inprogress, :complete]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :upcoming
  end
end
