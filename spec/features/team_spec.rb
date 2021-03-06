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
      click_link 'Edit'
      click_link 'Delete'
      expect(Team.count).to eq 1

      visit '/teams'
      click_link other_team.name
      click_link 'Edit'
      click_link 'Delete'
      expect(Team.count).to eq 0
    end
  end

  context 'Team Captain' do
    let!(:user) { regular_sign_in }

    scenario 'can invite existing users to join team' do
      other_user = create(:user)
      team = create(:team, created_by: user, captain: user)
      team.starters << user
      expect(team.members.count).to eq 1

      visit "/teams/#{team.id}"
      click_link 'edit-roster'
      fill_in 'Email', with: other_user.email
      click_button 'Send invite'
      member = team.members.last
      expect(page).to have_content 'Invited'
      expect(team.members.count).to eq 2
      expect(member.accepted_at).to be nil
      expect(member.token).to_not be nil
    end

    scenario 'can invite new users to join team' do
      team = create(:team, created_by: user, captain: user)
      email = 'fake@email.com'
      expect(User.find_by(email: email)).to be nil

      visit "/teams/#{team.id}"
      click_link 'edit-roster'
      fill_in 'Email', with: 'fake@email.com'
      click_button 'Send invite'
      expect(User.find_by(email: email)).to_not be nil
    end

    scenario 'can change user role on team'

    scenario 'can remove players'

    scenario 'can change players roles in team'

    scenario 'can edit team profile'

    scenario 'can disband team'

    scenario 'cannot not modify count of wins/losses/draws for team'

  end

  context 'Regular user' do
    let!(:user) { regular_sign_in }

    scenario 'cannot view all teams' do
      other_user = create(:user)
      team = create(:team, created_by: other_user, captain: other_user)

      visit '/teams'
      expect(page).to_not have_content team.name
    end

    scenario 'cannot modify teams' do
      other_user = create(:user)
      team = create(:team, created_by: other_user, captain: other_user)

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

    scenario 'can accept team invite after making an account from invitation' do
      team = create(:team)
      # all the stuff that would hapepn when user is invited
      team.alternates << user
      member = team.members.last
      member.generate_token!
      member.touch(:invited_at)

      visit '/teams'
      expect(page).to have_content team.name
      expect(page).to have_link 'Accept invite'
      expect(page).to have_link 'Decline invite'
    end

    scenario 'can request to join teams'
  end
end