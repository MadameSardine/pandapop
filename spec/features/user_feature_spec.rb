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

  end



end