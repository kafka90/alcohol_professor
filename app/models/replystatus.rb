class Replystatus < ActiveRecord::Base
    
  belongs_to :reply
  belongs_to :user
  
end
