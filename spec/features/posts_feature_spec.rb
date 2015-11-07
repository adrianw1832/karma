require 'rails_helper'

feature 'Posts feature' do
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
end
