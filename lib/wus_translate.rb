# require "rtranslate"
require 'google_translate'

class WusTranslate
  
  def initialize
    @translator = Google::Translator.new
  end  
    
  def translate_text(text, destination, source="en")
    # Use whatever libraries are available
    # result = Translate.t(text, Language::ENGLISH, Language::CHINESE_SIMPLIFIED)
    @translator.translate(source.to_sym, destination.to_sym, text)
  end
  
  def translation_available?
    # try and do a test translation with the available gems
    
  end
  
end