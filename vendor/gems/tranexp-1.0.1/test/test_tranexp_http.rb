require File.dirname(__FILE__) + '/test_helper.rb'

class TestTranexpHttp < Test::Unit::TestCase
  attr_reader :translate

  def setup
    @translate = Tranexp::Http.new
  end

  def test_english_to_norwegian
    if_connected do
      assert_nothing_thrown do
        english = translate.translate("metoder", Tranexp::Http::Norwegian, Tranexp::Http::English)
        assert_equal("methods", english)
      end
    end
  end

  def test_utf8_from_eng_to_nor
    if_connected do
      assert_nothing_thrown do
        english = translate.translate("i would like to learn Norwegian", Tranexp::Http::English, Tranexp::Http::Norwegian)
        assert_equal("jeg ville like å høre Norsk", english)
      end
    end
  end

  def test_english_to_norwegian_method_missing
    translate.expects(:translate).with("metoder", "nor", "eng").returns("methods")
    if_connected do
      assert_nothing_thrown do
        english = translate.from_nor_to_eng("metoder")
        assert_equal("methods", english)
      end
    end
  end

end
