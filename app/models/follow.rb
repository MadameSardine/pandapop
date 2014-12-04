class Follow < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user
end
