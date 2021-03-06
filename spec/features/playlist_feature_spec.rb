require 'rails_helper'

describe 'playlist management', js: true do

  def search_for_taylor_swift
    visit '/'
    fill_in 'search-content', with: 'taylor swift'
    click_button 'search'
  end

  before do
    preload_playlists
  end

  context 'User is not logged in' do

    before do
      @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
      @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
    end

    it 'should not see a link to playlists' do
      visit '/'
      find('#nav-bar-slide-out').click
      expect(page).not_to have_link "my playlists"
    end

    it "should not be able to access another user's playlists page" do
      visit user_playlists_path(@panda)
      expect(current_path).to eq new_user_session_path
  end

    it 'should not be able to access a playlist page' do
      visit playlist_path(@taylorjamz)
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'User is logged in' do

    before do
      @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
      login_as @panda
      @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
      @beyonce = Playlist.create(user: @panda, name: "Best of Beyonce")
      @shakeitoff = Track.create(title: "Shake it off", duration: 'PT4M23S')
      @taylorjamz.tracks << @shakeitoff
      @koala = User.create(email: 'koala123@test.com', username: 'koala123', first_name: 'koala', last_name: 'pop', password: 'koalapop123', password_confirmation: 'koalapop123')
      @koalaplaylist = Playlist.create(user: @koala, name: "koala's best of")
    end

    context 'playlist viewing' do

      it 'a user can access his playlists page' do
        visit '/'
        find('#nav-bar-slide-out').click
        click_link "my playlists"
        expect(current_path).to eq user_playlists_path(@panda)
      end

      it 'a user can see his playlists' do
        visit user_playlists_path(@panda)
        expect(page).to have_content 'Taylor Swift Jamz'
        expect(page).to have_content 'Best of Beyonce'
      end

      it "can see another user's playlists" do
        visit user_playlists_path(@koala)
        expect(current_path).to eq user_playlists_path(@koala)
        expect(page).to have_content "koala123's playlists"
      end

      it 'a user can access the playlist page of another user' do
        visit playlist_path(@koalaplaylist)
        expect(current_path).to eq playlist_path(@koalaplaylist)
        expect(page).to have_content "koala's best of"
      end

      it 'a user can go to a playlist page' do
        visit user_playlists_path(@panda)
        click_link 'Taylor Swift Jamz'
        expect(current_path).to eq playlist_path(@taylorjamz)
      end

      it 'a user can see the tracks in the playlist' do
        visit playlist_path(@taylorjamz)
        expect(page).to have_content("Shake it off")
      end

      it 'a playlist uploaded without an image should have the default missing image displayed on the home page' do
        visit playlist_path(@taylorjamz)
        expect(page).to have_selector("img[src$='missing.png']")
      end

    end

    context 'playlist management' do

      it 'user can see a link to create a playlist' do
        visit user_playlists_path(@panda)
        expect(page).to have_link 'New playlist'
      end

      it 'should be able to create a playlist with a name' do
        visit user_playlists_path(@panda)
        click_link 'New playlist'
        expect(current_path).to eq new_user_playlist_path(@panda)
        fill_in "Name", with: "Taylor Swift Jamz"
        click_button "Create playlist"
        expect(page).to have_content "Playlist successfully created"
      end

      xit 'a user can see a link to add to playlist from the home page', js: true do
        visit '/'
        fill_in 'search-content', with: "Beyonce"
        click_button "search"
        expect(page).to have_button 'Add to playlist'
        expect(page).to have_css('#track_playlists')
      end

      xit 'a user can select a playlist to add the track to'do
        visit '/'
        fill_in 'search-content', with: "Beyonce"
        click_button "search"
        within '#results' do
          find('#track_playlists', match: :first)
          find('.add-to-playlist-link', match: :first).click
        end
        expect(page).to have_content('Track successfully added to playlist')
      end

      it 'a user can see a delete a track link' do
        visit playlist_path(@taylorjamz)
        expect(page).to have_selector('.delete-track-icon')
      end

      it 'a user can delete a track from a playlist' do
        visit playlist_path(@taylorjamz)
        click_link 'delete-track-icon'
        expect(page).to have_content('Track successfully removed from playlist')
      end

      it 'a user can delete a playlist' do
        visit playlist_path(@taylorjamz)
        click_link 'delete-playlist-icon'
        expect(current_path).to eq '/'
        expect(page).to have_content('Playlist has been successfully deleted')
      end

      context 'users can only manage their own playlists' do

        before do
          @koala = User.create(email: 'koala123@test.com', username: 'koala123', first_name: 'koala', last_name: 'bear', password: 'pandapop123', password_confirmation: 'pandapop123')
          @koalajamz = Playlist.create(user: @koala, name: "Koala Jamz")
        end

        it 'a user can only see his own playlists on the home page' do
          visit '/'
          search_for_taylor_swift
          expect(page).not_to have_content "Koala Jamz"
        end

        xit 'a user should only see his own playlists in the dropdown menu' do
          visit '/'
          search_for_taylor_swift
          expect(page).to have_xpath('//div/main/section/article/form/select[@id = "track_playlists"]/option[text() = "Taylor Swift Jamz"]')
          expect(page).not_to have_xpath('//div/main/section/article/form/select[@id = "track_playlists"]/option[text() = "Koala Jamz"]')
        end

      end

    end

  end

end

