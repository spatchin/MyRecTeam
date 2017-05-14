
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

  5.times do
    users = FactoryGirl.create_list(:user, 10)
    team = FactoryGirl.create(:team)
    team.starters = users[0...5]
    team.alternates = users[5...10]
    team.members.find_by(user: users[0]).update(captain: true)
    team.members.each(&:accept!)
    team.save!
    p team
  end

  admin.teams << Team.all.sample(2)
  regular.teams << Team.all.sample(2)

  FactoryGirl.create_list(:game, 5, team: Team.all.sample)
end