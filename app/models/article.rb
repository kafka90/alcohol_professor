class Article < ActiveRecord::Base
    
    has_many :replies
    has_many :statuses
    has_many :users, through: :statuses
  
    mount_uploader :my_image, ImageUploaders
 
end
