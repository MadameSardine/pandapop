require 'rails_helper'

describe 'youtube searches' do

  context 'display searched results' do

    before do
      visit '/'
      fill_in 'top-bar-search', with: "Taylor Swift"
      click_button 'search-button'
    end

    it 'a user can see Taylor Swifts name in the search results', js: true do
      expect(page).to have_content 'Taylor Swift'
    end

    it 'a user sees only four results (and 1 for the template)', js: true do
      expect(page).to have_selector('.track-box', count: 5)
    end

    it 'a user should see a video title', js: true do
      expect(page).to have_selector('.title')
    end

    it 'a user should see a video duration', js: true do
      expect(page).to have_selector('.duration')
    end

    it 'a user should see a video view count', js: true do
      expect(page).to have_selector('.viewCount')
    end

    it 'a user should see a video like count', js: true do
      expect(page).to have_selector('.likeCount')
    end

    it 'a user should see a thumbnail', js: true do
      expect(page).to have_selector('.thumbnail')
    end

    it 'a user should click on a thumbnail and see a video on the player page', js: true do
      within "#results" do
        find('.track-box', match: :first).click
      end
      expect(current_path).to eq '/player'
      expect(page).to have_selector('#player-iframe')
    end

  end
end
