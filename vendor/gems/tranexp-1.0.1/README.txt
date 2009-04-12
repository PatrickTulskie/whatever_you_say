= tranexp

* http://tranexp.rubyforge.org

== DESCRIPTION:

Translates words or phrases from one language to another, using 
http://www.tranexp.com:2000/Translate/result.shtml

== FEATURES/PROBLEMS:

Has a command-line and API.

=== Command Line

To translate some text from Danish to English:

    cat some_danish_text.txt | tranexp dan eng
    
    echo "jeg ville like en flaske vin" | tranexp nor
    I would like a bottle of wine

That is, you pass the input text via STDIN. The default target language is English ('eng').

=== API

To translate some text from English to Norwegian:
  
    translate = Tranexp::Http.new
    english = translate.translate("metoder", Tranexp::Http::Norwegian, Tranexp::Http::English)
    english = translate.translate("metoder", "nor", "eng")
    
Or use the dynamic helper:
  
    translate.from_nor_to_eng("metoder")

== SYNOPSIS

* Translates between the following languages:
  "English" => "eng",
  "BrazilianPortuguese" => "pob",
  "Bulgarian" => "bul",
  "Croatian" => "cro",
  "Czech" => "che",
  "Danish" => "dan",
  "Dutch" => "dut",
  "Spanish" => "spa",
  "Finnish" => "fin",
  "French" => "fre",
  "German" => "ger",
  "Greek" => "grk",
  "Hungarian" => "hun",
  "Icelandic" => "ice",
  "Italian" => "ita",
  "Japanese" => "jpn",
  "Latin American Spanish" => "spl",
  "Norwegian" => "nor",
  "Filipino" => "tag",
  "Polish" => "pol",
  "Portuguese" => "poe",
  "Romanian" => "rom",
  "Russian" => "rus",
  "Serbian" => "sel",
  "Slovenian" => "slo",
  "Swedish" => "swe",
  "Welsh" => "wel",
  "Turkish" => "tur",
  "Latin" => "ltt"

Future versions might support the 2 character abbreviations for languages; currently
it just supports the 3 character codes used within tranexp.

== REQUIREMENTS:

* mechanize rubygem
* internet connection

== INSTALL:

* gem install tranexp

Or fetch the source from:

* github: http://github.com/drnic/tranexp/tree/master

    git clone git://github.com/drnic/tranexp.git
    cd tranexp
    rake test
    rake install_gem

* rubyforge: http://rubyforge.org/scm/?group_id=6064

    git clone git://rubyforge.org/tranexp.git
    cd tranexp
    rake test
    rake install_gem
    

== LICENSE:

Copyright (c) 2008 Dr Nic Williams

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.