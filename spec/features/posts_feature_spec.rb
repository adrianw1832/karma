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
    end
  end

  context 'viewing posts' do
    let!(:post) { create(:post) }

    context 'user is logged in' do
      scenario 'user can click and view the post' do
        sign_in_as(user)
        click_link 'I need a lift'
        expect(current_path).to eq post_path(post)
        expect(page).to have_content 'I need a lift'
        expect(page).to have_content 'I need to go to the supermarket'
      end
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

  context 'updating posts' do
    let!(:post) { create(:post) }

    context 'user is logged in' do
      scenario 'the original user can edit the post' do
        sign_in_as(user)
        visit root_path
        click_link 'I need a lift'
        click_link 'Edit Post'
        fill_in 'Title', with: 'I need two lifts'
        fill_in 'Description', with: 'I need to go to two supermarkets'
        click_button 'Update Post'
        expect(current_path).to eq posts_path
        expect(page).to have_content 'I need two lifts'
        click_link 'I need two lifts'
        expect(page).to have_content 'I need to go to two supermarkets'
      end
    end
  end
end
