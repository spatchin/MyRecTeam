# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'Game' do
  context 'Admin' do
  end

  context 'Team captain' do
    let!(:user) { regular_sign_in }

    scenario "can set games to time and location" do
      team = create(:team, captain: user)
      team.starters << user
      game = create(:game, team: team)
      time = 1.hour.from_now.localtime
      location = 'here'

      visit "/games/#{game.id}"
      click_link 'Edit'
      select time.strftime('%b'), from: 'game_time_2i'
      select time.day, from: 'game_time_3i'
      select time.year, from: 'game_time_1i'
      select time.strftime('%I %p'), from: 'game_time_4i'
      select time.strftime('%M'), from: 'game_time_5i'
      fill_in 'Location', with: location
      click_button 'Update'
      game = game.reload
      expect(game.time.localtime.strftime('%D %H:%M %p')).to eq time.strftime('%D %H:%M %p')
      expect(game.location).to eq location
    end

    scenario 'can change game status' do
      team = create(:team, captain: user)
      team.starters << user
      game = create(:game, team: team, time: 2.hours.from_now)

      visit "/games/#{game.id}"
      expect(page).to have_link 'Cancel'
      expect(page).to have_button 'Complete'
    end

    scenario 'can create game which queues game reminders to team members' do
      team = create(:team, captain: user)
      team.starters << user
      team.starters << create_list(:user, 3)

      visit '/games'
      click_link 'New game'
      fill_in 'Name', with: 'test'
      fill_in 'Location', with: 'test'
      expect(Delayed::Job.count).to eq 0

      click_button 'Create Game'
      preferred_email_times = Game.last.players.map { |u| u.preference.game_email_reminder.strftime('%I %M %p') }
      delayed_jobs = Delayed::Job.all.map { |dj| [dj.run_at.strftime('%D'), dj.run_at.strftime('%I %M %p')] }
      expect(delayed_jobs.map(&:last)).to eq preferred_email_times
      expect(delayed_jobs.map(&:first).uniq).to eq [Date.today.strftime('%D')]
    end

    scenario "can report score"
    scenario "can view team attendance for game"
  end

  context 'Regular user' do
    let!(:user) { regular_sign_in }

    scenario "cannot set games to time and location" do
      team = create(:team)
      team.members.create(user: user, role: :starter)
      game = create(:game, team: team)
      time = Time.current.beginning_of_hour
      location = 'here'

      visit "/games/#{game.id}"
      expect(page).to_not have_link 'Edit'

      visit "/games/#{game.id}/edit"
      expect(page).to have_content 'not authorized'
    end

    scenario "can report their attendance as attending" do
      team = create(:team)
      team.starters << user
      game = create(:game, team: team, time: 1.hour.from_now.localtime)

      visit "/games/#{game.id}"
      click_link 'Attending'
      expect(page).to have_content 'Going'
      expect(UserAttendance.order(:updated_at).last.status).to eq 'attending'
    end

    scenario "can report their attendance as absent" do
      team = create(:team)
      team.starters << user
      game = create(:game, team: team, time: 1.hour.from_now.localtime)

      visit "/games/#{game.id}"
      click_link 'Not Attending'
      expect(page).to have_content 'Not Going'
      expect(UserAttendance.order(:updated_at).last.status).to eq 'absent'
    end

    scenario 'cannot change game status' do
      team = create(:team)
      team.starters << user
      game = create(:game, team: team, time: 1.hour.from_now.localtime)

      visit "/games/#{game.id}"
      expect(page).to_not have_link 'Cancel'
      expect(page).to_not have_link 'Complete'
    end

    scenario 'can view game status--canceled' do
      team = create(:team)
      team.starters << user
      game = create(:game, :canceled, team: team, time: 1.hour.ago.localtime)

      visit "/games/#{game.id}"
      expect(page).to have_content 'Canceled'
    end

    scenario 'can view game status--complete' do
      team = create(:team)
      team.starters << user
      game = create(:game, :win, team: team, time: 1.hour.ago.localtime)

      visit "/games/#{game.id}"
      expect(page).to have_content 'Result'
    end

    scenario 'can comment on game' do
      team = create(:team)
      team.starters << user
      game = create(:game, team: team, time: 1.hour.from_now.localtime)

      visit "/games/#{game.id}"
      expect(page).to have_content 'Comments'
      fill_in 'comment-comment', with: 'test commentz'
      click_button 'submit-comment'
      expect(page).to have_content 'test commentz'
    end
  end
end