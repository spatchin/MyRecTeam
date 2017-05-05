
if Rails.env.development?
  User.destroy_all
  Team.destroy_all
  Game.destroy_all

  p u = FactoryGirl.create(:admin_user)
  u.confirm
  p uu = FactoryGirl.create(:user, email: 'user@email.com', first_name: 'Regular', last_name: 'User')
  uu.confirm

  FactoryGirl.create_list(:team, 5)
  FactoryGirl.create_list(:game, 5)
  Game.all.each do |g|
    g.teams = Team.all.sample(2)
  end
end