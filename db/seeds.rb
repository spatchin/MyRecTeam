
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

  FactoryGirl.create_list(:team, 5,)
  Team.first.captain = u
  Team.all.each do |t|
    t.captain = FactoryGirl.create(:user)
    t.starters = FactoryGirl.create_list(:user, 5)
    t.alternates = FactoryGirl.create_list(:user, 3)
  end

  FactoryGirl.create_list(:game, 5)
  Game.all.each do |g|
    teams = Team.all.sample(2)
    g.team_attendances << TeamAttendance.create(team: teams[0])
    g.team_attendances << TeamAttendance.create(team: teams[1])
  end
end