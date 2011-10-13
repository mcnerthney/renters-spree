class ARentsController < Spree::BaseController
  
  def index
     @items = Item.all
     respond_to do |format|
       format.html #index.html.erb
       format.json { render json: @items.to_json() }
     end
    
  end
  
  def show
     @item = Item.find(params[:id])
     respond_to do |format|
       format.html #show.html.erb
       format.json { render json: @item }
     end
    
  end

end
