class Owner < ActiveRecord::Base
    has_many :items
    validates_uniqueness_of :user_id
end
