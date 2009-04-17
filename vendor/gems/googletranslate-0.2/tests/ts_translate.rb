$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'test/unit'
require 'rtranslate'

class TranslateTest < Test::Unit::TestCase
  include Language
  def test_english_translate
    assert_equal("مرحبا العالم", Translate.t("Hello world", ENGLISH, ARABIC));
    assert_equal("你好世界", Translate.t("Hello world", ENGLISH, CHINESE_SIMPLIFIED));
    assert_equal("Bonjour le monde", Translate.t("Hello world", ENGLISH, FRENCH));
    assert_equal("Hallo welt", Translate.t("Hello world", ENGLISH, GERMAN));
    assert_equal("Ciao a tutti", Translate.t("Hello world", ENGLISH, ITALIAN));
    assert_equal("こんにちは世界", Translate.t("Hello world", ENGLISH, JAPANESE));
    assert_equal("여러분, 안녕하세요", Translate.t("Hello world", ENGLISH, KOREAN));
    assert_equal("Olá mundo", Translate.t("Hello world", ENGLISH, PORTUGUESE));
    assert_equal("Привет мир", Translate.t("Hello world", ENGLISH, RUSSIAN));
    assert_equal("Hola mundo", Translate.t("Hello world", ENGLISH, SPANISH));
  end

  def test_chinese_translate
    assert_equal("Hello World", Translate.t("你好世界", CHINESE, ENGLISH))
    assert_equal("Hello World", Translate.t("你好世界", 'zh', 'en'))
  end

  def test_unsupported_translate
    assert_raise UnsupportedLanguagePair do
      Translate_t("Hello World", Translate.t("你好世界", 'zh-CN', 'en'))
    end
  end
end
