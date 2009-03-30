class Language < ActiveRecord::Base
  
  validates_uniqueness_of :name
  validates_uniqueness_of :short_name
  has_many :profiles
  has_many :users, :through => :profiles
  
end
