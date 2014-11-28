require 'rails_helper'

describe 'User' do

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

  it 'user will be redirected to home page if no video is selected' do
    visit '/player'
    expect(current_path).to eq root_path
  end

  it 'user sees a link to go to home page' do
    visit '/'
    expect(page).to have_link('Home')
  end

  it 'user can navigate to home page' do
    visit '/'
    click_link 'Home'
    expect(current_path).to eq '/'
  end

  context 'Using the tracks queue' do 

    def search_for_simple_plan
      visit '/'
      fill_in 'search-content', with: 'simple plan'
      click_button 'search'
    end

     it 'should see a queue bar' do 
      visit '/'
      expect(page).to have_content 'Queue'
      expect(page).to have_selector('#queue-bar')
    end

    it 'should be able to add songs to the queue', js: true do 
      search_for_simple_plan
      expect(page).to have_content 'Simple Plan'
      within('#results') do 
        click_link('Add to queue', :match => :first)
      end
      within ('#queue-bar') do 
        expect(page).to have_content 'Simple Plan'
      end
    end

    it 'the queue should persist after a new search', js: true do 
      search_for_simple_plan
      within('#results') do 
        click_link('Add to queue', :match => :first)
      end
      fill_in 'search-content', with: 'taylor swift'
      click_button 'search'
      within ('#queue-bar') do 
        expect(page).to have_content 'Simple Plan'
      end
    end

    it 'should be able to clear the queue', js: true do 
      search_for_simple_plan
      click_button 'Clear queue'
      within ('#queue-bar') do 
        expect(page).not_to have_content 'Simple Plan'
      end
    end

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