class ItemsController < Spree::BaseController
  
  #controller for maintaining items
  
  before_filter :set_store
  # GET /items
  # GET /items.json
  def index

    if @store.nil? || @store.user_id != User.current.id 
      redirect_to root_path
    else
      @items = @store.items
      respond_to do |format|
        format.android
        format.html # index.html.erb
        format.json { render json: @items }
      end
    end
    
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find_by_id_and_store_id(params[:id],params[:store_id])
    if @item.nil? || @item.store.user_id != User.current.id 
      redirect_to root_path
    else
      respond_to do |format|
        format.android # show.html.erb
        format.html # show.html.erb
        format.json { render json: @item }
      end
    end
    
  end

  # GET /items/new
  # GET /items/new.json
  def new
    
    if @store.nil? || @store.user_id != User.current.id 
      redirect_to root_path
    else
    
    @item = Item.new
    @item.location = "Portland, OR"
    @item.active   = true
    
    respond_to do |format|
      format.android # new.html.erb
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end
end
  # GET /items/1/edit
  def edit
    if @store.nil? || @store.user_id != User.current.id 
      redirect_to root_path
    else
    
    @item = Item.find(params[:id])
  end
end

  # POST /items
  # POST /items.json
  def create
    if @store.nil? || @store.user_id != User.current.id 
      redirect_to root_path
    else
    
    @item = Item.new(params[:item])
    @item.active   = true
    
    @item.store = @store
    respond_to do |format|
      if @item.save
        format.android { redirect_to store_items_path(@store), notice: 'Item was successfully created.' }
        format.html    { redirect_to store_items_path(@store), notice: 'Item was successfully created.' }
        format.json    { render json: @item, status: :created, location: @item }
      else
        format.html {  render action: "new" }
        format.android {  render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
    end
    
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    if @store.nil? || @store.user_id != User.current.id 
      redirect_to root_path
    else
    
    @item = Item.find(params[:id])
 
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.android { redirect_to store_item_path(@store,@item), notice: 'Item was successfully updated.' }
        format.html { redirect_to store_item_path(@store,@item), notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.android { render action: "edit"}
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if @store.nil? || @store.user_id != User.current.id 
      redirect_to root_path
    else
    
      @item = Item.find(params[:id])
      @item.destroy

      respond_to do |format|
        format.android { redirect_to store_items_path(@store) }
        format.html    { redirect_to store_items_path(@store) }
        format.json    { head :ok }
      end
    end
  end
  
  private
    def set_store
      if  !User.current.nil? 
        @store = Store.find_by_id_and_user_id(params[:store_id], User.current.id)
      end
    end

  
end
