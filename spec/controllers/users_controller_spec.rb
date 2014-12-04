require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  before(:each) do
    @panda = create(:user)
    @spike = User.create(username: "Spike", email: "spike@panda.com", password: "pandasarecute", password_confirmation: "pandasarecute")
    @panda.follow!(@spike)
  end

  xit 'should show user following' do
    expect(page).to have_content('')
  end

end
