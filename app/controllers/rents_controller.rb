class RentsController < Spree::BaseController

  before_filter :set_user
  
  def index
    if ( params[:s] == "newitem"  )
      if @user.nil? 
         unauthorized
       else
         if @user.stores.empty?
            @store = Store.new(params[:store])
            @store.user_id = @user.id
            @store.activate
            if @store.save
              redirect_to new_store_item_path(@store)
            else
              redirect_to :show
            end
         else
           redirect_to new_store_item_path(@user.stores.first)
         end
       end
    else
    
     @items = Item.find_all_by_active(true);
       respond_to do |format|
         format.html # index.html.erb
         format.json { render json: @items.to_json() }
     end
     end  
     
  end
  
  def show
     @item = Item.find(params[:id])
     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @item }
     end
    
  end
  private
     def set_user
       @user =  Thread.current[:user]
     end      

end
