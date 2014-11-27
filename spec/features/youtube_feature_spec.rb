require 'rails_helper'

describe 'youtube searches' do

  context 'display searched results' do

    before do
      visit '/'
      fill_in 'search-content', with: "Taylor Swift"
      click_button 'search-button'
    end

    it 'a user can see Taylor Swifts name in the search results' do
      expect(page).to have_content 'Taylor Swift'
    end

    it 'a user sees only four results' do
      expect(page).to have_selector('.search-result-container', count: 4)
    end

    it 'a user should see a video title' do
      expect(page).to have_selector('.title')
    end

    it 'a user should see a video duration' do
      expect(page).to have_selector('.duration')
    end

    it 'a user should see a video view count' do
      expect(page).to have_selector('.viewCount')
    end

    it 'a user should see a video like count' do
      expect(page).to have_selector('.likeCount')
    end

    it 'a user should see a thumbnail' do
      expect(page).to have_selector('.thumbnail')
    end

    xit 'a user should click on a thumbnail and see a video on the player page' do
      within "#results" do
        find('.track-box', match: :first).click
      end
      expect(current_path).to eq '/player'
      expect(page).to have_selector('#player-iframe')
    end

  end
end
