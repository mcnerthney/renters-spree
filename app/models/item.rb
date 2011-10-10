class Item < ActiveRecord::Base
  attr_accessible :description, :location
  belongs_to :store
end
