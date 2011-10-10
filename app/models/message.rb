class Message < ActiveRecord::Base
  attr_accessible  :subject, :body, :recipient_id
  is_private_message
  
end