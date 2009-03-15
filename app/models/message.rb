class Message < ActiveRecord::Base
  
  belongs_to :chat
  belongs_to :sender, :class_name => "User"
  
  validates_length_of :body, :minimum => 1
  
end
