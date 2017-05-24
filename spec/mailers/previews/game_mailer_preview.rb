# Preview all emails at http://localhost:3000/rails/mailers/game_mailer
class GameMailerPreview < ActionMailer::Preview
  def game_reminder
    game = Game.first

    if game.nil?
      team = FactoryGirl.create(:team)
      team.starters = FactoryGirl.create_list(:user, 5)
      game = FactoryGirl.create(:game, team: team)
    end

    player = game.players.first
    attendance_link = '#'

    GameMailer.game_reminder(player, attendance_link, game)
  end
end
