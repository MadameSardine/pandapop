require 'rails_helper'

describe 'playlist management' do

  def sign_up_as_panda
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'panda@test.com'
    fill_in 'Username', with: 'Panda123'
    fill_in 'First name', with: 'Panda'
    fill_in 'Last name', with: 'Pop'
    fill_in 'Password', with: 'pandapop123'
    fill_in 'Password confirmation', with: 'pandapop123'
    click_button 'Sign up'
  end

  context 'User is not logged in' do
    it 'should not see a link to create a playlist' do
      visit '/'
      expect(page).not_to have_content "New playlist"
    end
  end

  context 'User is logged in' do

    before do
      @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
      login_as @panda
      @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
      @beyonce = Playlist.create(user: @panda, name: "Best of Beyonce")
      @shakeitoff = Track.create(title: "Shake it off", duration: 'PT4M23S' )
      @taylorjamz.tracks << @shakeitoff
    end

    context 'playlist viewing' do

      it 'a user can go to a playlist page' do
        visit '/'
        expect(page).to have_content 'Taylor Swift Jamz'
        click_link 'Taylor Swift Jamz'
        expect(current_path).to eq playlist_path(@taylorjamz)
      end

      it 'a user can see the tracks in the playlist' do
        visit playlist_path(@taylorjamz)
        expect(page).to have_content("Shake it off")
        expect(page).to have_content("PT4M23S")
      end

    end

    context 'playlist editing, deleting' do

      it 'user can see a link to create a playlist' do
        visit '/'
        expect(page).to have_link 'Create playlist'
      end

      it 'should be able to create a playlist with a name' do
        visit '/'
        click_link 'Create playlist'
        expect(current_path).to eq new_playlist_path
        fill_in "Name", with: "Taylor Swift Jamz"
        click_button "Create playlist"
        expect(page).to have_link "Taylor Swift Jamz"
      end

      it 'a user can see a link to add to playlist from the home page', js: true do
        visit '/'
        fill_in 'search-content', with: "Beyonce"
        click_button "search"
        expect(page).to have_button 'Add to playlist'
        expect(page).to have_css('#track_playlists')
      end

      it 'a user can select a playlist to add the track to'do
        visit '/'
        fill_in 'search-content', with: "Beyonce"
        click_button "search"
        within '#results' do
          find('#track_playlists', match: :first)
          find('.add-to-playlist-link', match: :first).click
        end
        expect(page).to have_content('Track successfully added to playlist')
      end

    end

  end
end
