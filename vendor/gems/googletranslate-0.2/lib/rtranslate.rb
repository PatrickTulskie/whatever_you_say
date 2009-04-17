require 'rtranslate/language'
require 'rtranslate/rtranslate'
require 'uri'
require 'open-uri'

begin
  require 'hpricot'
rescue LoadError
  require 'rubygems'
  require 'hpricot'
end

include Translate
def Translate.t(text, from, to)
  begin
    RTranslate.translate(text, from, to)
  rescue
    "Error: " + $!
  end
end

