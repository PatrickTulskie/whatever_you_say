require 'wus_translate'
class Message < ActiveRecord::Base
  
  belongs_to :chat
  belongs_to :sender, :class_name => "User"
  belongs_to :language
  
  validates_length_of :body, :minimum => 1
  
  def translate(destination_language)
    t = Google::Translator.new
    t.translate(self.language.short_name.to_sym, destination_language.to_sym, self.body)
  end  
  
end
