require 'rails_helper'

describe 'youtube searches' do

  context 'display searched results' do
    it 'a user can search for Taylor Swift', js: true do
      visit '/'
      fill_in 'top-bar-search', with: "Taylor Swift"
      click_button 'search-button'
      expect(page).to have_content 'Taylor Swift'
    end
  end
end
