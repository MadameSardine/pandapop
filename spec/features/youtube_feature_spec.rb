require 'rails_helper'

describe 'youtube searches' do

  def preload_playlists
    @playlist1 = Playlist.create(name: "Makers Jamz")
    @playlist2 = Playlist.create(name: "Friday Night")
    @playlist3 = Playlist.create(name: "Katy Perry Jamz")
    @playlist4 = Playlist.create(name: "Taylor Swift Jamz")
  end

  before do
    preload_playlists
  end

  context 'display searched results when searching for Taylor Swift' do

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

    xit 'a user should see a video view count' do
      expect(page).to have_selector('.viewCount')
    end

    xit 'a user should see a video like count' do
      expect(page).to have_selector('.likeCount')
    end

    it 'a user should see a thumbnail' do
      expect(page).to have_selector('.thumbnail')
    end

    it 'a user should click on a thumbnail and see a video on the player page', js: true do
      within "#results" do
        find('.title-and-thumbnail', match: :first).click
      end
      expect(page).to have_selector('#player-iframe')
    end

  end
end
