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

    xit 'a user can see Taylor Swifts name in the search results' do
      expect(page).to have_content 'Taylor Swift'
    end

    it 'a user sees search results' do
      expect(page).to have_selector('.search-result-container')
    end

    it 'a user should see a video title' do
      expect(page).to have_selector('.title')
    end

    it 'a user should see a thumbnail' do
      expect(page).to have_selector('.thumbnail')
    end

    xit 'a user should see a video player' do
      expect(page).to have_selector('#player-iframe')
    end

  end
end
