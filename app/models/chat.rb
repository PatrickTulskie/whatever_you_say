class Chat < ActiveRecord::Base
  
  has_many :messages
  belongs_to :receiver, :class_name => "User"
  belongs_to :user
  
  def details_for(participant)
    participant_type = user_id == participant.id ? 'user' : 'receiver'
    details_hash = {
      :unread_count => 0 + self.messages.length - (eval("#{participant_type}_read_count") || 0),
      :closed => eval("#{participant_type}_closed"),
      :participant_type => participant_type
    }
    return details_hash
  end  
  
  def participants_include?(possible_participant)
    p = User.find(possible_participant)
    response = false
    response = true if (self.user == p) || (self.receiver == p)
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
    self.save
  end
  
  def close_for(user_object)
    logger.info user_id
    logger.info user_object.id
    if user_id == user_object.id
      self.user_closed = true
    else
      self.receiver_closed = true
    end
    self.save
  end
  
  def self.find_all_by_member(member_id)
    chats = Chat.find_all_by_user_id(member_id)
    chats += Chat.find_all_by_receiver_id(member_id)
    chats.sort{ |a,b| a.created_at <=> b.created_at }
    return chats
  end
  
  def self.new_between_participants(user_hash)
    # Should resemble this
    # users_hash => {:user => current_user, :receiver => receiving_user}
    # Clean it up a bit if not...
    user_hash.reject!{ |key,value| !%w(user_id receiver_id).include?(key.to_s) }
    
    user = User.find(user_hash[:user_id])
    receiver = User.find(user_hash[:receiver_id])
    user_search = user.chat_with_user(receiver)
    receiver_search = receiver.chat_with_user(user)
    chat = if user_search
      user_search
    elsif receiver_search
      receiver_search
    else
      Chat.create(user_hash)
    end
    chat.user_closed = false
    chat.receiver_closed = false
    return chat
  end
    
end
