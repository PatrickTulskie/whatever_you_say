class WusTranslate
      
  def translate_text(text, destination, source="en")
    # Use whatever libraries are available    
    result = text

    result = translate_with_shvet_google_translate(text, source, destination)
    if text == result || (result.match(/Error: Translation from /))
      result = translate_with_google_translate(text, source, destination)
    end
    if (text == result) || (result.match(/Error: Translation from /))
      result = translate_with_tranexp(text, source, destination)
    end
    
    return result
  end
  
  private
  
  def translate_with_shvet_google_translate(text, source, destination)
    require 'google_translate'
    result = text
    begin
      shvet_google = Google::Translator.new
      result = shvet_google.translate(source.to_sym, destination.to_sym, text)
    rescue
      # Just do nothing...
    ensure
      return result
    end
  end  
  
  def translate_with_google_translate(text, source, destination)
    require 'rtranslate'
    result = text
    begin
      result = Translate.t(text, source, destination)
    rescue
      # Nothing!
    ensure
      return result
    end
  end
  
  def translate_with_tranexp(text, source, destination)
    require 'tranexp'
    result = text
    begin
      tran_source = eval("Tranexp::Http::#{Language.find_by_short_name(source).name}")
      tran_dest = eval("Tranexp::Http::#{Language.find_by_short_name(destination).name}")
      tranexp = Tranexp::Http.new
      result = tranexp.translate(text, tran_source, tran_dest)
    rescue
      # just do nothing
    ensure
      return result
    end
  end
  
end