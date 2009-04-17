module Tranexp::Codes
  @@codes = {
    "English" => "eng",
    "Brazilian Portuguese" => "pob",
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
  }
  @@codes.each_pair { |name, code| self.const_set(name.gsub(/\s+/, ''), code) }
end
