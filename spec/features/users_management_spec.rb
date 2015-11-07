require 'rails_helper'

feature 'Users management' do
  context 'user is not signed in and is on the homepage' do
    scenario 'should see a sign in link and a sign up link' do
      visit root_path
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    scenario 'should not see a sign out link' do
      visit root_path
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'user is signed in and is on the homepage' do
    before do
      visit root_path
      click_link 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'test1234'
      fill_in 'Password confirmation', with: 'test1234'
      click_button 'Sign up'
    end

    scenario 'should see a sign out link' do
      visit root_path
      expect(page).to have_link 'Sign out'
    end

    scenario 'should not see a sign in and sign up link' do
      visit root_path
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end
  end
end
