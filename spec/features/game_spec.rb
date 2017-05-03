# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'Game' do
  context 'Admin' do
  end
  
  context 'Regular user' do
    scenario "as team captain can set games to time and location"
    scenario "as team captain can set games to type (soccer, softball, etc)"
    scenario "can report their attendance"
    scenario "as team captain can view team attendance for game"
    scenario "as team captains can report scores (if scores don't match, open dispute)"
    scenario "can view game status (pending, complete, in_dispute)"
    scenario "can view game status notes ('team 1 wins, team 2 forfeits, etc')"
  end
end