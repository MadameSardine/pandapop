require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "friendships" do

    before(:each) do
      @spike = User.create(username: "Spike", email: "spike@spike.com", password: "fixingshit", password_confirmation: "fixingshit")
      @nicole = User.create(username: "Nicole", email: "nicole@terriblecode.com", password: "breakingshit", password_confirmation: "breakingshit")

      # @panda = create(:user)
      # @followed = build(:user, email: "pop@panda.com")
    end

    it "should have a friendships method" do
      expect(@panda).to respond_to(:friendships)
    end

    it 'should have a following method' do
      expect(@panda).to respond_to(:followed_users)
    end

    it "should have a following? method" do
      expect(@panda).to respond_to(:following?)
    end

    it "should have a follow! method" do
      expect(@panda).to respond_to(:follow!)
    end

    it "should follow another user" do
      @nicole.follow!(@spike)
      p @nicole.friendships
      p @nicole.following?(@spike) == true
      # p @panda
      # p @followed
      # @panda.follow!(@followed)
      # expect(@panda).to be_following(@followed)
    end

    it "should include the followed user in the following array" do
      @panda.follow!(@followed)
      expect(@panda.followed_users).to include(@followed)
    end

    it "should have an unfollow! method" do
      expect(@followed).to respond_to(:unfollow!)
    end

    it "should unfollow a user" do
      @panda.follow!(@followed)
      @panda.unfollow!(@followed)
      expect(@panda).not_to be_following(@followed)
    end

      it "should have a reverse_friendships method" do
      expect(@panda).to respond_to(:reverse_friendships)
    end

    it "should have a followers method" do
      expect(@panda).to respond_to(:followers)
    end

    it "should include the follower in the followers array" do
      @panda.follow!(@followed)
      expect(@followed.followers).to include(@panda)
    end

  end
end
