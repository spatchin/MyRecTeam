# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'User' do
  context 'Admin' do
    scenario 'can modify user attributes'
  end
  
  context 'Regular user' do
    scenario 'can view all users'
    scenario 'cannot modify user attributes'
    scenario 'can register teams'
    scenario 'have profiles with pictures'
    scenario 'can have role (admin, mod, user) and team_role'
  end
end