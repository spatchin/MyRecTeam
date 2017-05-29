# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  team_id     :integer
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

  enum role: [:starter, :alternate]
  after_initialize :set_default_role, if: :new_record?

  validates :role, presence: true
  validates :user, uniqueness: { scope: :team }

  def set_default_role
    self.role ||= :alternate
  end

  def generate_token!
     self.token = Digest::SHA1.hexdigest([self.user_id, Time.now, rand].join)
     save!
  end

  def accept!
    touch(:accepted_at)
  end

  def clear_token!
    update(token: nil)
  end

  def accepted?
    accepted_at.present?
  end
end
