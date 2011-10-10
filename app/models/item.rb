class Item < ActiveRecord::Base
  attr_accessible :description, :location
  belongs_to :store
  belongs_to :user
end
