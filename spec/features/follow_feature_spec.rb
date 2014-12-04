require 'rails_helper'

describe 'follow playlists' do

  before do
    @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
    @koala = User.create(email: 'koala123@test.com', username: 'koala123', first_name: 'koala', last_name: 'bear', password: 'pandapop123', password_confirmation: 'pandapop123')
    @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
  end

  context 'User is logged in' do

    before do
      login_as @panda
    end

    it 'should see link to follow a playlist' do
    end

  end


end