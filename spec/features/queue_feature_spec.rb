require 'rails_helper'

describe 'queue management' do

  before do
   @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
    @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
  end

  def search_for_simple_plan
    visit '/'
    fill_in 'search-content', with: 'simple plan'
    click_button 'search'
  end

  def search_for_taylor_swift
    fill_in 'search-content', with: 'taylor swift'
    click_button 'search'
  end

  # def add_first_result_to_queue
  #   within '#results' do
  #     find('.add-to-queue', match: :first).click
  #   end
  # end

  # def create_taylor_jamz_playlist
  #   visit '/'
  #   find('#nav-bar-slide-out').click
  #   click_link "my playlists"
  #   click_link 'New playlist'
  #   expect(current_path).to eq new_playlist_path
  #   fill_in "Name", with: "Taylor Swift Jamz"
  #   click_button "Create playlist"
  # end

  # before do
  #   preload_playlists
  # end

  context 'when landing on the home page' do

    it 'a user should see a queue bar' do
      visit '/'
      expect(page).to have_content 'Play queue'
      expect(page).to have_selector('#queue-bar')
    end

  end

  context 'after a user has made a search for simple plan ' do

    before :each do
      search_for_simple_plan
      # add_first_result_to_queue
    end

    # after :each do
    #   click_button 'Clear'
    # end

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

    it 'a user should be able to clear queue', js: true  do
      find('#clear-queue').click
      within ('#queue-bar') do
        expect(page).not_to have_content 'Simple Plan'
      end
    end

    it 'should see a link to play queue' do
      expect(page).to have selector('#play-queue')
    end

    it 'the queue should persist after a new search', js: true do
      search_for_taylor_swift
      within ('#queue-bar') do
        expect(page).to have_content 'Simple Plan'
      end
    end

  end

  context 'user is logged in' do

    it 'a user can add a full playlist to the queue', js: true do
      login_as @panda
      visit user_playlist_path(panda, )
      click_link 'Queue up playlist'
      expect(page).to have_css('.queue-item', text: 'Shake it off')
    end

  it 'a user can add a specific track from a playlist to the queue', js: true do
      sign_up_as_panda
      create_taylor_jamz_playlist
      visit '/'
      find('#nav-bar-slide-out').click
      click_link "my playlists"
      click_link 'Taylor Swift Jamz'
      find('.add-playlist-track-to-queue', match: :first).click
      expect(page).to have_css('.queue-item', text: 'Shake it off')
    end

  end



  it 'should be able to go to the next song in a queue, removing the previously played track', js: true  do
    search_for_simple_plan
    add_first_result_to_queue
    expect(page).to have_selector('.queue-item', count: 1)
    search_for_taylor_swift
    add_first_result_to_queue
    visit '/'
    within ('#queue-bar') do
      expect(page).to have_selector('.queue-item', count: 2)
    end
    click_button 'Play'
    click_button 'Next'
    within ('#queue-bar') do
      expect(page).not_to have_content 'Simple Plan'
      expect(page).to have_selector('.queue-item', count: 1)
    end
  end

end
