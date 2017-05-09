# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'Team' do
  context 'Admin' do
    let!(:user) { sign_in }

    scenario 'can modify all teams' do
      team = create(:team, created_by: user, captain: user)
      other_user = create(:user)
      other_team = create(:team, created_by: other_user, captain: other_user)

      visit '/teams'
      expect(page).to have_content team.name
      expect(page).to have_content other_team.name

      click_link team.name
      click_link 'Delete'
      expect(Team.count).to eq 1

      visit '/teams'
      click_link other_team.name
      click_link 'Delete'
      expect(Team.count).to eq 0
    end
  end

  context 'Regular user' do
    let!(:user) { regular_sign_in }

    scenario 'can view all teams' do
      other_user = create(:user)
      team = create(:team, created_by: other_user, captain: other_user)

      visit '/teams'
      expect(page).to have_content team.name
    end

    scenario 'cannot modify teams' do
      other_user = create(:user)
      team = create(:team, created_by: other_user, captain: other_user)

      visit '/teams'
      click_link team.name
      expect(page).to_not have_content 'Edit'

      visit "/teams/#{team.id}/edit"
      expect(page).to have_content 'You are not authorized'
    end

    scenario 'can register team' do
      attributes = attributes_for(:team)

      visit '/teams'
      click_link 'New team'
      fill_in 'Name', with: attributes[:name]
      fill_in 'Description', with: attributes[:description]
      fill_in 'Location', with: attributes[:location]
      click_button 'Create Team'

      new_team = Team.last
      expect(new_team.name).to eq attributes[:name]
      expect(new_team.created_by).to eq user
      expect(new_team.captain).to eq user
    end

    scenario 'as team captains can add/remove players' do

    end

    scenario 'can request to join teams'

    scenario 'can have role on team'

    scenario 'as team captains can invite users to join team'

    scenario 'as team captains can assign users to team_roles (captain, starter, sub)'

    scenario 'as team captains can edit team profile'

    scenario 'as team captains can disband team'

    scenario 'can edit but not modify count of wins/losses/draws for team'
  end
end