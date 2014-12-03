class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :playlists
  has_many :friendships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :friendships, source: :followed

  has_many :reverse_friendships, foreign_key: "followed_id", class_name: "Friendship", dependent: :destroy
  has_many :followers, through: :reverse_friendships, source: :follower

  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def self.authenticate_with_salt(id, cookie_salt)

  end

  def following?(followed)
    friendships.find_by_followed_id(followed)
  end

  def follow!(followed)
    self.friendships.create!(followed_id: followed.id)
  end

  def unfollow!(followed)
    friendships.find_by_followed_id(followed).destroy
  end

end
