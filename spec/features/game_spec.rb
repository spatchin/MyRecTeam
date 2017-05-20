# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'Game' do
  context 'Admin' do
  end

  context 'Regular user' do
    let!(:user) { regular_sign_in }

    scenario "as team captain, can set games to time and location" do
      team = create(:team)
      team.members.create(user: user, role: :starter, captain: true)
      game = create(:game, team: team)
      time = Time.current.beginning_of_hour
      location = 'here'

      visit "/games/#{game.id}"
      click_link 'Edit'
      select time.time.strftime('%b'), from: 'game_time_2i'
      select time.day, from: 'game_time_3i'
      select time.year, from: 'game_time_1i'
      select time.strftime('%I %p'), from: 'game_time_4i'
      select '00', from: 'game_time_5i'
      fill_in 'Location', with: location
      click_button 'Update'
      expect(page).to have_content 'successfully updated'
      expect(game.reload.attributes.slice('time', 'location').values).to eq [time, location]
    end

    scenario "can report their attendance as attending" do
      team = create(:team)
      team.members.create(user: user, role: :starter)
      game = create(:game, team: team, time: 2.hours.from_now)

      visit "/games/#{game.id}"
      click_link 'Attending'
      expect(page).to have_content 'Going'
      expect(UserAttendance.order(:updated_at).last.status).to eq 'attending'
    end

    scenario "can report their attendance as absent" do
      team = create(:team)
      team.members.create(user: user, role: :starter)
      game = create(:game, team: team, time: 2.hours.from_now)

      visit "/games/#{game.id}"
      click_link 'Not Attending'
      expect(page).to have_content 'Not Going'
      expect(UserAttendance.order(:updated_at).last.status).to eq 'absent'
    end

    scenario 'can view game status--canceled' do
      team = create(:team)
      team.members.create(user: user, role: :starter)
      game = create(:game, :canceled, team: team, time: 2.hours.from_now)

      visit "/games/#{game.id}"
      expect(page).to have_content 'Canceled'
    end

    scenario 'can view game status--canceled' do
      team = create(:team)
      team.members.create(user: user, role: :starter)
      game = create(:game, :completed, team: team, time: 2.hours.from_now)

      visit "/games/#{game.id}"
      expect(page).to have_content 'Score'
    end

    scenario "as team captain, can report score" do

    end

    scenario "as team captain, can view team attendance for game"
    scenario "can view game status notes ('team 1 wins, team 2 forfeits, etc')"
  end
end