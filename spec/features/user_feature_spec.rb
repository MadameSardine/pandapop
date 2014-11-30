require 'rails_helper'

describe 'User' do

  def preload_playlists 
    @playlist1 = Playlist.create(name: "Makers Jamz")
    @playlist2 = Playlist.create(name: "Friday Night")
    @playlist3 = Playlist.create(name: "Katy Perry Jamz")
    @playlist4 = Playlist.create(name: "Taylor Swift Jamz")
  end

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

  before do 
    preload_playlists
  end

  it 'user will be redirected to home page if no video is selected' do
    visit '/player'
    expect(current_path).to eq root_path
  end

  it 'user sees a link to go to home page' do
    visit '/'
    expect(page).to have_css('#home-icon')
  end

  it 'user can navigate to home page' do
    visit '/'
    find('#home-icon').click
    expect(current_path).to eq '/'
  end

  context 'User is not logged in' do

    it 'should see a link to sign up' do
      visit '/'
      expect(page).to have_link 'Sign up'
    end

    it 'should see a link to sign in' do
      visit '/'
      expect(page).to have_link 'Sign in'
    end

    it 'should be able to sign up' do
      sign_up_as_panda
      expect(page).to have_content 'Welcome!'
    end

    it 'should not see a sign out link' do
      expect(page).not_to have_link 'Sign out'
    end

    it 'should see a list of recommended playlists before entering search query' do 
      visit '/'
      expect(page).to have_selector('#pandapop-playlists')
      expect(page).to have_content('Our favorite playlists')
    end

    it 'should no longer see recommended playlists after entering search query' do 
      visit '/'
      fill_in 'search-content', with: 'taylor swift'
      click_button 'search'
      expect(page).not_to have_selector('#pandapop-playlists')
      expect(page).not_to have_content('Our favorite playlists')
    end

  end

  context 'User is logged in' do

    it 'should see a sign out link' do
      sign_up_as_panda
      expect(page).to have_link 'Sign out'
    end

    it 'should not see a sign in or sign up link' do
      sign_up_as_panda
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end

  end

end