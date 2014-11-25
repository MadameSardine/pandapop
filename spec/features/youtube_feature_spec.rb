require 'rails_helper'

describe 'youtube searches' do

  context 'display searched results' do

    before do
      visit '/'
      fill_in 'top-bar-search', with: "Taylor Swift"
      click_button 'search-button'
    end

    it 'a user can see Taylor Swifts name in the search results', js: true do
      expect(page).to have_content 'Taylor Swift'
    end

    it 'a user sees only three results', js: true do
      expect(page).to have_selector('.embedVideo', count: 3)
    end
  end
end
