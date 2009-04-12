require 'wus_translate'
class Message < ActiveRecord::Base
  
  belongs_to :chat
  belongs_to :sender, :class_name => "User"
  belongs_to :language
  
  validates_length_of :body, :minimum => 1
  
  def translate(destination_language)
    w = WusTranslate.new
    w.translate_text(self.body, destination_language.to_sym, self.language.short_name.to_sym)
  end  
  
end
