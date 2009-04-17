class Tranexp::Http
  include Tranexp::Codes
  PostURL = "http://www.tranexp.com:2000/Translate/result.shtml"

  def translate(text, from, to="eng")
    @agent ||=  WWW::Mechanize.new
    page = @agent.post(PostURL, {
      :from => from,
      :to   => to,
      :text => text,
      :keyb => "non",
      "Submit.x" => 33,
      "Submit.y" => 9,
      :translation => ""
    })
    clean_up page.forms[1]['translation']
  end

  # Support calls like #from_nor_to_eng, or #from_eng_to_
  def method_missing(meth, *args, &blk)
    if meth.to_s =~ /^from_([a-z]+)_to_([a-z]+)$/
      from, to = $1, $2
      return translate(args.first, from, to)
    end
    super
  end

  protected
  def clean_up dirty_text
    newstr = ""
    dirty_text.each_byte do |character|
      newstr += if character < 0x80
        character.chr
      elsif character < 0xC0
        "\xC2" + character.chr
      else
        "\xC3" + (character - 64).chr
      end
    end
    newstr
  end
end

