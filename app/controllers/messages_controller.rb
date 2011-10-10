class MessagesController < Spree::BaseController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = @user.sent_messages
    else
      @messages = @user.received_messages
    end
    respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @messages }
     end
    
  end
  
  def show
    @message = Message.read(params[:id], current_user)
    respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @message }
     end
    
  end
  
  def new
    @message = Message.new

    if params[:reply_to]
      @reply_to = @user.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @message.to = @reply_to.sender.login
        @message.subject = "Re: #{@reply_to.subject}"
        @message.body = "\n\n*Original message*\n\n #{@reply_to.body}"
      end
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
    
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = @user
    @message.recipient = @user # User.find_by_login(params[:message][:to])

    if @message.save
      flash[:notice] = "Message sent"
      redirect_to messages_path
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @user, @user])
          @message.mark_deleted(@user) unless @message.nil?
        }
        flash[:notice] = "Messages deleted"
      end
      redirect_to messages_path
    end
  end
  
  private
    def set_user
      @user =  Thread.current[:user]
    end
end