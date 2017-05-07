# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_members_on_team_id  (team_id)
#  index_members_on_user_id  (user_id)
#

class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum role: [:starter, :alternate]
  after_initialize :set_default_role, if: :new_record?

  validates :role, presence: true

  def set_default_role
    self.role ||= :starter
  end
end
