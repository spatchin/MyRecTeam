# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  username               :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default(0)
#  phone                  :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invitations_count     (invitations_count)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :user, aliases: [:created_by, :captain] do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    username { "#{(first_name[0] + last_name).downcase}" }
    email { "#{username}@email.com" }
    phone { Faker::PhoneNumber.cell_phone }
    password 'secret'
    password_confirmation 'secret'

    factory :admin_user do
      email 'admin@email.com'
      username 'admin'
      first_name 'Admin'
      last_name 'User'
      role :admin
    end

    after(:build) do |prof, eval|
      prof.skip_confirmation!
    end
  end
end

