require 'rails_helper'

describe 'tracks homepage' do

  context 'User not logged in' do

    it 'user can see top tracks recommendations' do
      visit '/'
      expect(page).to have_css('#top-bar-search')
    end

    it 'user can search for tracks' do
      visit '/'
      expect(page).to have_css('#search-button')
    end
  end
end