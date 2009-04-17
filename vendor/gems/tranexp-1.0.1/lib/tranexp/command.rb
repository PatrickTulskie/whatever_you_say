require 'optparse'
class Tranexp::Command
  def self.run(text, from, to="eng")
    translate = Tranexp::Http.new
    translate.translate(text, from, to)
  end
end
