require 'rails_helper'

describe 'tracks dashboard' do

  context 'User not logged in' do

    it 'user can see a search bar' do
      visit '/'
      expect(page).to have_css('#top-bar-search')
    end

    it 'user can search for tracks' do
      visit '/'
      expect(page).to have_css('#search-button')
    end

    it 'user can view top recommended tracks' do
      visit '/'
      expect(page).to have_css('.track-box')
      expect(page).to have_content('Top tracks')
    end

    it 'user can see a link to play a track' do 
      visit '/'
      expect(page).to have_link 'Play track'
    end

  end

  context 'User is logged in' do

    before do
      @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
      login_as @panda
      @shakeitoff = Track.create(title: 'Shake it off', youtube_url: "www.youtube.com/taylor", duration: "4.00", plays: "4")
      @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
    end

    it 'user can see followers and playlists' do
      visit '/'
      expect(page).to have_content 'Followers'
      expect(page).to have_content 'Playlists'
    end

    it 'user can see a link to play a track' do 
      visit '/'
      expect(page).to have_link 'Play track'
    end

    context 'adding a new track' do 

      it 'a user can see a link to submit a new track' do 
        visit '/'
        expect(page).to have_link 'Upload new track'
      end

      it 'a user can click a link and submit a new track' do 
        visit '/'
        click_link 'Upload new track'
        expect(current_path).to eq new_track_path
        fill_in 'Title', with: 'Yesterday'
        fill_in 'Youtube Url', with: 'https://www.youtube.com/watch?v=GXHvnMZRGNQ'
        fill_in 'Duration', with: '2:13'
        fill_in 'Plays', with: 0
        click_button 'Create New Track'
        expect(current_path).to eq tracks_path
        expect(page).to have_content 'Yesterday'
      end

    end

  end

end