require 'rails_helper'

describe 'queue management' do

  before do
    visit '/'
    fill_in 'search-content', with: "Beyonce"
    click_button "search"
    within '#results' do
      find('.add-to-queue', match: :first).click
    end
  end

  it 'should be able to add a track to the queue', js: true  do
    expect(page).to have_link 'Add to queue'
    expect(page).to have_css(".queue-item")
  end

  it 'should be able to clear queue', js: true  do
    click_button 'Clear queue'
    expect(page).not_to have_css(".queue-item")
  end

  it 'should be able to play queue', js: true  do
    click_button 'Play queue'
    expect(current_path).to eq '/player'
  end

  xit 'should be able to go to the next song in a queue', js: true  do
    fill_in 'search-content', with: "Burning down the house"
    click_button "search"
    within '#results' do
      find('.add-to-queue', match: :first).click
    end
    click_button 'Play queue'
    expect(page).to have_content "Beyonce"
    within "#queue-bar" do
      find('#next-in-queue').click
    end
    expect(page).not_to have_content "Beyonce"
  end

end
