require 'rails_helper'

RSpec.describe Friendship, :type => :model do

  before(:each) do

    @follower = create(:user)
    @followed = create(:user)

    @friendship = @follower.friendships.build(followed_id: @followed.id)
  end

  it 'should create a new instance given valid attributes' do
    @friendship.save!
  end

  describe 'follow methods' do

    before(:each) do
      @friendship.save
    end

    it 'should have a follower attribute' do
      expect(@friendship).to respond_to(:follower)
    end

    it 'should have the right follower' do
      expect(@friendship.follower).to eq(@follower)
    end

    it 'should have a followed attribute' do
      expect(@friendship).to respond_to(:followed)
    end

    it 'should have the right followed user' do
      expect(@friendship.followed).to eq(@followed)
    end
  end

  describe "validations" do

    it "should require a follower_id" do
      @friendship.follower_id = nil
      expect(@friendship).not_to be_valid
    end

    it "should require a followed_id" do
      @friendship.followed_id = nil
      expect(@friendship).not_to be_valid
    end
  end
end
