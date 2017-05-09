class TeamMailer < ApplicationMailer

  # must ensure the user exists first
  def add_player_email(path, team, user)
    @path = path
    @team = team
    @user = user
    mail(to: @user.email, subject: "New Team Invitation")
  end
end
