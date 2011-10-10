class RentsController < Spree::BaseController

  #controller for renting items

  before_filter :set_user
  
  def index
     @items = Item.all
     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @messages }
     end
    
  end
  
  def show
     @item = Item.find(params[:id])
     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @messages }
     end
    
  end


  private
     def set_user
       @user =  Thread.current[:user]
     end

end
