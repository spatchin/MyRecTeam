class GameMailer < ApplicationMailer
  def game_reminder(user, attending_link, absent_link, game)
    @user = user
    @attending_link = attending_link
    @absent_link = absent_link
    @game = game

    mail(to: @user.email, subject: "You have a game today")
  end
end
