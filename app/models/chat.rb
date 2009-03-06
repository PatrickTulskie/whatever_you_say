class Chat < ActiveRecord::Base
  
  has_many :messages
  belongs_to :receiver, :class_name => "User"
  belongs_to :user
  
  def participants_include?(possible_participant)
    p = User.find(possible_participant)
    response = false
    response = true if (self.user == p) || (self.receiver == p)
  end
  
  def self.find_all_by_member(member_id)
    chats = Chat.find_all_by_user_id(member_id)
    chats += Chat.find_all_by_receiver_id(member_id)
    chats.sort{ |a,b| a.created_at <=> b.created_at }
    return chats
  end
  
end
