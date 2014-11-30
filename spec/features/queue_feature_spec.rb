require 'rails_helper'

describe 'queue management when user not logged in' do

  def search_for_simple_plan
    visit '/'
    fill_in 'search-content', with: 'simple plan'
    click_button 'search'
  end

  def search_for_taylor_swift 
    visit '/'
    fill_in 'search-content', with: 'taylor swift'
    click_button 'search'
  end

  def add_first_result_to_queue
    within '#results' do 
      find('.add-to-queue', match: :first).click
    end
  end

  it 'should see a queue bar' do 
    visit '/'
    expect(page).to have_content 'Queue'
    expect(page).to have_selector('#queue-bar')
  end

  context 'a user searches for simple plan and adds the first track to the queue' do 

    before do 
      search_for_simple_plan
      add_first_result_to_queue
    end

    it 'should be able to add a track to the queue', js: true  do
      within ('#queue-bar') do 
        expect(page).to have_content 'Simple Plan'
      end
    end

    it 'should be able to clear queue', js: true  do
      click_button 'Clear'
      within ('#queue-bar') do 
        expect(page).not_to have_content 'Simple Plan'
      end
    end

    it 'should be able to play queue', js: true  do
      click_button 'Play'
      expect(current_path).to eq '/player'
    end

    it 'the queue should persist after a new search', js: true do 
      search_for_taylor_swift
      within ('#queue-bar') do 
        expect(page).to have_content 'Simple Plan'
      end
    end
  end

  it 'should be able to go to the next song in a queue, removing the previously played track', js: true  do
    search_for_simple_plan
    add_first_result_to_queue
    search_for_taylor_swift
    add_first_result_to_queue
    within ('#queue-bar') do 
      expect(page).to have_selector('.queue-item', count: 2)
    end    
    click_button 'Play'
    click_button 'Next'
    within ('#queue-bar') do 
      expect(page).not_to have_content 'Simple Plan'
      expect(page).to have_selector('.queue-item', count: 1)
    end
  end

end
