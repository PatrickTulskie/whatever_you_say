class BuddyGroup < ActiveRecord::Base
  
  has_many :buddies
  belongs_to :user
  
end
