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
  
  def get_unread_messages(user)
    u = User.find(user)
    if self.user_id == u.id
      read_count = self.user_read_count || 0
      self.user_read_count = self.messages.length
    else
      read_count = self.receiver_read_count || 0
      self.receiver_read_count = self.messages.length
    end
    unread_count = self.messages.length - read_count
    self.save
    return self.messages.last(unread_count)
  end
  
  def mark_all_read(user)
    u = User.find(user)
    if self.user_id == u.id
      self.user_read_count = self.messages.length
    else
      self.receiver_read_count = self.messages.length
    end
  end
  
    
end
