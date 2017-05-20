
if Rails.env.development?
  User.destroy_all
  Team.destroy_all
  Game.destroy_all
  Member.destroy_all
  UserAttendance.destroy_all

  p admin = FactoryGirl.create(:admin_user)
  admin.confirm
  p regular = FactoryGirl.create(:user, email: 'user@email.com', first_name: 'Regular', last_name: 'User')
  regular.confirm

  3.times do
    users = FactoryGirl.create_list(:user, 8)
    users += [admin, regular]
    team = FactoryGirl.create(:team)
    team.starters = users[0...5]
    team.alternates = users[5...10]
    team.members.find_by(user: users[0]).update(captain: true)
    team.members.each(&:accept!)
    team.save!
    p team
  end

  FactoryGirl.create(:game, team: Team.all.sample, time: 1.day.ago)
  FactoryGirl.create(:game, team: Team.all.sample, time: Time.now)
  FactoryGirl.create(:game, team: Team.all.sample, time: 1.day.from_now)
end