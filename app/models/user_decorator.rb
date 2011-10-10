User.class_eval do
   has_many :stores
   has_many :items
   has_private_messages
end
