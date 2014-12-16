class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
      if user.nil?
        can :read, Playlist
      else
        can :manage, Playlist, :user_id => user.id
        can :manage, Track
      end

  end
end
