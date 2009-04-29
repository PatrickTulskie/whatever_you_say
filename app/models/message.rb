require 'wus_translate'
class Message < ActiveRecord::Base
  
  belongs_to :chat
  belongs_to :sender, :class_name => "User"
  belongs_to :language
  
  validates_length_of :body, :minimum => 1
  
  after_create :reopen_chat
  
  def translate(destination_language)
    w = WusTranslate.new
    w.translate_text(self.body, destination_language.to_sym, self.language.short_name.to_sym)
  end
  
  def reopen_chat
    c = self.chat
    c.user_closed = false
    c.receiver_closed = false
    c.save
  end  
    
end
