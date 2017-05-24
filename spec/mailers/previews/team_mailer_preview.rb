# Preview all emails at http://localhost:3000/rails/mailers/team_mailer
class TeamMailerPreview < ActionMailer::Preview
  def add_player_email
    accept_link = '#'
    deny_link = '#'
    team = Team.first

    if team.present?
      user = team.captain
    else
      team = FactoryGirl.create(:team)
      team.captain = user
    end

    TeamMailer.add_player_email(accept_link, deny_link, team, user)
  end
end
