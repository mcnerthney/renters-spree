class MessagesController < Spree::BaseController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = @use_user.sent_messages
    else
      @messages = @use_user.received_messages
    end
  end
  
  def show
    @message = Message.read(params[:id], current_user)
  end
  
  def new
    @message = Message.new

    if params[:reply_to]
      @reply_to = @use_user.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @message.to = @reply_to.sender.login
        @message.subject = "Re: #{@reply_to.subject}"
        @message.body = "\n\n*Original message*\n\n #{@reply_to.body}"
      end
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = @use_user
    @message.recipient = UseUser.find_by_login(params[:message][:to])

    if @message.save
      flash[:notice] = "Message sent"
      redirect_to user_messages_path(@use_user)
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @use_user, @use_user])
          @message.mark_deleted(@use_user) unless @message.nil?
        }
        flash[:notice] = "Messages deleted"
      end
      redirect_to user_message_path(@use_user, @messages)
    end
  end
  
  private
    def set_user
      @use_user = User.current
    end
end