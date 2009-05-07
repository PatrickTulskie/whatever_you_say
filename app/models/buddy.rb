class Buddy < ActiveRecord::Base
  
  belongs_to :buddy_group
  belongs_to :user
  
  validates_uniqueness_of :user_id, :scope => :buddy_group_id, :message => "is already in your buddylist."
  validates_presence_of :buddy_group_id
  validates_presence_of :user_id, :message => "could not be found.  Please try again."
  
end
