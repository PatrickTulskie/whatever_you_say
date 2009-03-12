class Profile < ActiveRecord::Base
  
  # Relationships
  belongs_to :user
  
end
