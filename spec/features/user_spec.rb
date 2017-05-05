# The main context for testing will be non-admins.
# Having an admin context ensures that an admin has all privileges necessary to
# view, correct, or remove data
# However, the non-admin context will ensure that the more advanced features can
# be properly used by a regular user
feature 'User' do
  context 'Admin' do
    scenario 'can modify user attributes' do
      other_user = create(:user)
      sign_in

      visit '/users'
      click_link other_user.display_name
      click_link 'Edit'
      fill_in 'First name', with: 'New name'
      click_button 'Update User'
      expect(page).to have_content 'New name'
      expect(other_user.reload.first_name).to eq 'New name'
    end

    scenario 'can view all users' do
      other_user = create(:user)
      sign_in

      visit '/users'
      expect(page).to have_content other_user.display_name
    end
  end
  
  context 'Regular user' do
    scenario 'can sign up' do
      attributes = attributes_for(:user)
      
      visit '/users/sign_up'
      fill_in 'Email', with: attributes[:email]
      fill_in 'Username', with: attributes[:username]
      fill_in 'First name', with: attributes[:first_name]
      fill_in 'Last name', with: attributes[:last_name]
      fill_in 'Password', with: attributes[:password]
      fill_in 'Password confirmation', with: attributes[:password_confirmation]
      click_button 'Sign up'

      expect(User.count).to eq 1
    end

    scenario 'can view all users' do
      regular_sign_in
      visit '/users'
      expect(page).to have_content 'Users'
      expect(page).to have_content 'Username'
    end

    scenario 'can view all user profiles' do
      regular_sign_in
      other_user = create(:user)

      visit '/users'
      click_link other_user.display_name
      expect(page).to have_content 'Profile'
      expect(page).to have_content other_user.display_name
    end

    scenario 'cannot modify user attributes' do
      regular_sign_in
      other_user = create(:user)

      visit "/users/#{other_user.id}"
      expect(page).to have_content 'You are not authorized'      
    end

    scenario 'have profiles with pictures'

  end
end