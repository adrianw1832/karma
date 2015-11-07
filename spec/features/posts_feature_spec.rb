require 'rails_helper'

feature 'Posts feature' do
  let(:user) { create(:user) }

  context 'no posts have been created' do
    scenario 'should prompt the use to do add new posts' do
      visit posts_path
      expect(page).to have_content 'No posts have been added yet'
      expect(page).to have_link 'Add a new post'
    end
  end

  context 'posts have been created' do
    let!(:post) { create(:post) }

    scenario 'should be able to see it on the page' do
      visit posts_path
      expect(page).to have_content 'I need a lift'
      expect(page).to have_content 'I need to go to the supermarket'
    end
  end

  context 'creating posts' do
    context 'user is logged in' do
      scenario 'user can create a new post' do
        sign_in_as(user)
        visit root_path
        click_link 'Add a new post'
        fill_in 'Title', with: 'I need a lift'
        fill_in 'Description', with: 'I need to go to the supermarket'
        click_button 'Create Post'
        expect(current_path).to eq posts_path
        expect(page).to have_content 'I need a lift'
        expect(page).to have_content 'I need to go to the supermarket'
      end
    end

    context 'user is not logged in' do
      scenario 'user cannot create a new post and is redirected' do
        visit root_path
        click_link 'Add a new post'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'
      end
    end
  end
end
