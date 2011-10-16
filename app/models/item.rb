class Item < ActiveRecord::Base
  attr_accessible :title, :description, :location, :active
  belongs_to :store
  
  validates :title,  :presence => true,
                     :length   => { :maximum => 150 }
  validates :description, :presence => true
  validates :location, :presence => true
  
  def deactivate 
     self.active = false
   end
   
   def activate 
     self.active = true
   end
        
   def active?
     self.active
   end
  
end
