
if Rails.env.development?
  User.destroy_all
  Team.destroy_all
  Game.destroy_all
  Member.destroy_all
  TeamAttendance.destroy_all
  UserAttendance.destroy_all

  p u = FactoryGirl.create(:admin_user)
  u.confirm
  p uu = FactoryGirl.create(:user, email: 'user@email.com', first_name: 'Regular', last_name: 'User')
  uu.confirm

  5.times do
    users = FactoryGirl.create_list(:user, 10)
    team = FactoryGirl.create(:team, captain: users[0])
    team.starters = users[0...5]
    team.alternates = users[5...10]
    team.members.each(&:accept!)
    team.save!
  end

  FactoryGirl.create_list(:game, 5)
  Game.all.each do |g|
    teams = Team.all.sample(2)
    g.team_attendances << TeamAttendance.create(team: teams[0])
    g.team_attendances << TeamAttendance.create(team: teams[1])
  end
end