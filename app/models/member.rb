# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  team_id     :integer
#  captain     :boolean          default(FALSE)
#  role        :integer
#  accepted_at :datetime
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_members_on_team_id  (team_id)
#  index_members_on_user_id  (user_id)
#

class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  before_create :generate_token

  enum role: [:starter, :alternate]
  after_initialize :set_default_role, if: :new_record?

  validates :role, presence: true
  validates :user, uniqueness: { scope: :team }

  def set_default_role
    self.role ||= :starter
  end

  def generate_token
     self.token = Digest::SHA1.hexdigest([self.user_id, Time.now, rand].join)
  end

  def accept!
    touch(:accepted_at)
  end

  def accepted?
    accepted_at.present?
  end
end
