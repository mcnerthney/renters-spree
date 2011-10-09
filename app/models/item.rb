class Item < ActiveRecord::Base
  attr_accessible :description
  belongs_to :owner
end
