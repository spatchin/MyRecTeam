require 'rails_helper'

module Features
  module SessionHelpers
    def sign_in
      @user = create :admin_user
      login
    end

    def regular_sign_in
      @user = create :user
      login
    end

    def login
      visit '/users/sign_in'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Sign in'
      @user
    end

    def sign_in_as(user)
      sign_out if @user
      @user = user
      login
    end

    def sign_out
      find('.navbar-right .dropdown-toggle').click
      click_link 'Log out'
      @user = nil
    end
  end
end
