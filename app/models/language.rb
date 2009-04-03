class Language < ActiveRecord::Base
  
  validates_uniqueness_of :name
  validates_uniqueness_of :short_name
  has_many :profiles
  has_many :users, :through => :profiles
  
  def self.languages_for_select
    Language.all.map{|lang| [lang.name, lang.id]}.sort{|a,b| a.first <=> b.first}
  end  
  
end
