class Store < ActiveRecord::Base
    attr_accessible :name
    has_many :items
    belongs_to :user
    
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
