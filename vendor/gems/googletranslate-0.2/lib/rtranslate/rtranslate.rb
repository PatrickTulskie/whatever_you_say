module Translate
  class UnsupportedLanguagePair < StandardError
  end

  class RTranslate
    @@GT_URL = "http://www.google.com/translate_t?langpair="
    @@PARAMS = {"User-Agent"=>"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.9) Gecko/20071025 Firefox/2.0.0.9", "Connection"=>"Keep-Alive", "Keep-Alive"=>"30"}

    class << self
      def translate(text, from, to)
        langpair = "#{from}|#{to}"
        if GoogleLanguage::AVAILABLE_PAIR.include?(langpair)
          url = @@GT_URL + langpair + "&text=" + text
          doc = open(URI.escape(url), @@PARAMS) { |f| Hpricot(f)}
          return doc.search("//div#result_box").inner_text
        else
          raise UnsupportedLanguagePair, "Translation from '#{from}' to '#{to}' isn't supported yet!"
        end
      end

      alias_method :t, :translate
    end
  end
end
