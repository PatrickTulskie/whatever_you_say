class Profile < ActiveRecord::Base
  
  # Relationships
  belongs_to :user
  belongs_to :language
    
end
