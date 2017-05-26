# Preview all emails at http://localhost:3000/rails/mailers/game_mailer
class GameMailerPreview < ActionMailer::Preview
  def game_reminder
    game = Game.first

    if game.nil?
      team = FactoryGirl.create(:team)
      team.starters = FactoryGirl.create_list(:user, 5)
      game = FactoryGirl.create(:game, team: team)
    end

    user = game.players.first
    attending_link = '#'
    absent_link = '#'

    GameMailer.game_reminder(user, attending_link, absent_link, game)
  end
end
