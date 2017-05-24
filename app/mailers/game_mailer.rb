class GameMailer < ApplicationMailer
  def game_reminder(user, user_attendance_link, game)
    @user = user
    @user_attendance_link = user_attendance_link
    @game = game

    mail(to: @user.email, subject: "You have a game today")
  end
end
