require 'rails_helper'

describe 'tracks homepage' do

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

  end

  context 'User is logged in' do

    before do
      @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
      login_as @panda
    end

    it 'user can see followers and playlists' do
      visit '/'
      expect(page).to have_content 'Followers'
      expect(page).to have_content 'Playlists'
    end

    it 'user can see a link to create a playlist' do
      visit '/'
      expect(page).to have_link 'New playlist'
    end

  end

end