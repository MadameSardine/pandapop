require 'rails_helper'

describe 'queue management' do

  before do
   @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
    @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
    @shakeitoff = Track.create(title: "Shake it off", duration: 'PT4M23S')
      @taylorjamz.tracks << @shakeitoff
    visit '/'
  end

  def search_for_simple_plan
    fill_in 'search-content', with: 'simple plan'
    click_button 'search'
    sleep 3
  end

  def search_for_taylor_swift
    fill_in 'search-content', with: 'taylor swift'
    click_button 'search'
    sleep 3
  end

  context 'when landing on the home page' do

    it 'a user should see a queue bar' do
      expect(page).to have_content 'Play queue'
      expect(page).to have_selector('#queue-bar')
    end

  end

  context 'after a user has made a search for simple plan ' do

    before do
      search_for_simple_plan
    end

    it 'should be able to add a track to the queue', js: true  do
      within '#results' do
        find('.add-to-queue', match: :first).click
      end
      within ('#queue-bar') do
        expect(page).to have_content 'Simple Plan'
      end
    end

  end

  context 'after a track has been added to the queue' do

    before do
      search_for_simple_plan
      find('.add-to-queue', match: :first).click
    end

    it 'a user should be able to clear queue', js: true  do
      find('#clear-queue').click
      within ('#queue-bar') do
        expect(page).not_to have_content 'Simple Plan'
      end
    end

    it 'should see a link to play queue' do
      expect(page).to have_selector('#play-queue')
    end

    it 'the queue should persist after a new search', js: true do
      search_for_taylor_swift
      within ('#queue-bar') do
        expect(page).to have_content 'Simple Plan'
      end
    end
  end

  context 'after two tracks have been added to the queue' do


    it 'should be able to go to the next song in a queue, removing the previously played track', js: true  do
      find('#clear-queue').click
      search_for_simple_plan
      find('.add-to-queue', match: :first).click
      expect(page).to have_selector('.queue-item', count: 1)
      search_for_taylor_swift
      find('.add-to-queue', match: :first).click
      expect(page).to have_selector('.queue-item', count: 2)
      find('#play-queue').click
      find('#next-in-queue').click
      sleep 3
      within ('#queue-bar') do
        expect(page).not_to have_content 'Simple Plan'
        expect(page).to have_selector('.queue-item', count: 1)
      end
    end
  end

  context 'user is logged in' do

    before do
      login_as @panda
      visit user_playlist_path(@panda, @taylorjamz)
    end

    it 'a user can see a link to queue all tracks from a playlist' do
      expect(page).to have_selector('#play-all')
    end

    xit 'a user can add a playlist to the queue', js: true do
      find('#play-all').click
      expect(page).to have_css('.queue-item', text: 'Shake it off')
    end

    it 'a user can see a link to queue a track from a playlist' do
      expect(page).to have_selector('.add-playlist-track-to-queue')
    end

    xit 'a user can add a specific track from a playlist to the queue', js: true do
      find('.add-playlist-track-to-queue', match: :first).click
      expect(page).to have_css('.queue-item', text: 'Shake it off')
    end

  end

end
