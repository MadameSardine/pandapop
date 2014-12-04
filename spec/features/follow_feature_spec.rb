require 'rails_helper'

describe 'follow playlists' do

  before do
    @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
    @koala = User.create(email: 'koala123@test.com', username: 'koala123', first_name: 'koala', last_name: 'bear', password: 'pandapop123', password_confirmation: 'pandapop123')
    @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
  end

  context "user koala is logged in and visits panda's playlists pages" do

    before do
      login_as @koala
    end

    it "user koala should see link to follow a playlist from panda's playlists page" do
      visit user_playlists_path(@panda)
      expect(page).to have_link 'follow'
    end

    xit "user koala can follow a playlist from panda's playlists page" do
      visit user_playlists_path(@panda)
      click_link('follow', match: :first)
      expect(page).to have_content 'You are now following Taylor Swift Jamz'
    end

     it "user koala should see link to follow a playlist from panda's taylojamz playlist page" do
      visit playlist_path(@taylorjamz)
      expect(page).to have_link 'follow'
    end

     xit "user koala can follow a playlist ffrom panda's taylojamz playlist page" do
      visit playlist_path(@taylorjamz)
      click_link 'follow'
      expect(page).to have_content 'You are now following Taylor Swift Jamz'
    end

  end

  context "user panda is logged in and visit its own playlists page" do

    before do
      login_as @panda
    end

    it "should not be able to follow his own playlists from its playlists page" do
      visit user_playlists_path(@panda)
      expect(page).not_to have_link 'follow'
    end

     it "should not be able to follow his own playlist from its taylorjamz playlist page" do
      visit playlist_path(@taylorjamz)
      expect(page).not_to have_link 'follow'
    end

  end

end