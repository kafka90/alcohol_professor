class Reply < ActiveRecord::Base
    
     belongs_to :article
     has_many :replystatuses
     has_many :users, through: :replystatuses
     
end
