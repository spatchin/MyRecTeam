# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'Team' do
  context 'Admin' do
    scenario 'can modify all teams'
  end
  
  context 'Regular user' do
    scenario 'can view all teams'
    scenario 'cannot modify teams'
    scenario 'can register team'
    scenario 'can request to join teams'
    scenario 'can have role on team'
    scenario 'as team captains can invite users to join team'
    scenario 'as team captains can assign users to team_roles (captain, starter, sub)'
    scenario 'as team captains can edit team profile'
    scenario 'as team captains can disband team'
    scenario 'can view but not modify count of wins/losses/draws for team'
  end
end