require 'rails_helper'

describe 'User' do

  context 'User is not logged in' do

    it 'should be able to sign up' do
      visit '/'
      expect(page).to have_link 'Sign up'
    end

    it 'should be able to sign in' do
      visit '/'
      expect(page).to have_link 'Sign in'
    end

  end

end