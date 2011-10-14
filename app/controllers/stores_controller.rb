class StoresController < Spree::BaseController
  
    before_filter :check_authorization
    before_filter :check_registration, :except => [:registration, :update_registration]

    helper :users

    def registration
      @user = User.new
    end

    def update_registration
      
        if current_order.update_attributes(params[:order])
        redirect_to checkout_path
      else
        @user = User.new
        render 'checkout/registration'
      end
    end

 
  
  # GET /stores
  # GET /stores.json
  def index
    
    @user = User.current
    if @user.nil? 
      unauthorized
    else

      @stores = Store.find_all_by_user_id(@user.id)
      if @stores.nil?
        redirect_to :action => :new
      else
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @stores }
        end
      end
      
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    redirect_to :action => :index
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find_by_id_and_user_id(params[:id], User.current.id)
  end

  # POST /stores
  # POST /stores.json
  def create
    @user = User.current
     if @user.nil? 
       unauthorized
     else
      @store = Store.new(params[:store])
      @store.user_id = @user.id
      @store.activate
    
      respond_to do |format|
        if @store.save
          format.html { redirect_to new_store_item_path(@store), notice: 'Store was successfully created.' }
          format.json { render json: @store, status: :created, location: @store }
        else
          format.html { render action: "new" }
          format.json { render json: @store.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.json
  def update
    @store = Store.find_by_id_and_user_id(params[:id], User.current.id)

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to store_items_path(@store), notice: 'Store was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store = Store.find_by_id_and_user_id(params[:id], User.current.id)
    @store.deactivate
    @store.save

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :ok }
    end
  end
  
  private
   def check_authorization
     #authorize!(:edit, current_order, session[:access_token])
   end

   # Introduces a registration step whenever the +registration_step+ preference is true.
   def check_registration
     #return unless Spree::Auth::Config[:registration_step]
     #return if current_user or current_order.email
     #store_location
     #redirect_to checkout_registration_path
   end

   # Overrides the equivalent method defined in spree_core.  This variation of the method will ensure that users
   # are redirected to the tokenized order url unless authenticated as a registered user.
   def completion_route
     #return order_path(@order) if current_user
     #token_order_path(@order, @order.token)
   end

  
    
end
