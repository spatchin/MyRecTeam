class TeamMailer < ApplicationMailer

  # TODO: must ensure the user exists first
  def add_player_email(accept_link, deny_link, team, user)
    @accept_link = accept_link
    @deny_link = deny_link
    @team = team
    @user = user
    mail(to: @user.email, subject: "New Team Invitation")
  end
end
