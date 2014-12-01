module TestHelpers

  def preload_playlists 
    @playlist1 = Playlist.create(name: "Makers Jamz")
    @playlist2 = Playlist.create(name: "Friday Night")
    @playlist3 = Playlist.create(name: "Katy Perry Jamz")
    @playlist4 = Playlist.create(name: "Taylor Swift Jamz")
  end

  def sign_up_as_panda
    visit '/'
    find('#nav-bar-slide-out').click
    click_link 'Sign up'
    fill_in 'Email', with: 'panda@test.com'
    fill_in 'Username', with: 'Panda123'
    fill_in 'First name', with: 'Panda'
    fill_in 'Last name', with: 'Pop'
    fill_in 'Password', with: 'pandapop123'
    fill_in 'Password confirmation', with: 'pandapop123'
    click_button 'Sign up'
  end

end