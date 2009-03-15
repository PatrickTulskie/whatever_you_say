require "rtranslate"

class WusTranslate
  
  def initialize
    # Are translation services available?
    
  end  
    
  def translate_text(text, destination, source="en")
    # Use whatever libraries are available
    result = Translate.t(text, Language::ENGLISH, Language::CHINESE_SIMPLIFIED)
  end
  
  def translation_available?
    # try and do a test translation with the available gems
    
  end
  
end