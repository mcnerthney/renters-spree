class StoresController < Spree::BaseController
  # GET /stores
  # GET /stores.json
  def index
    
    @user = User.current
    if @user.nil? 
      redirect_to :action => :login
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
    @store = Store.find_by_id_and_user_id(params[:id], User.current.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.json
  def new
    
    @user = User.current
     if @user.nil? 
       redirect_to :action => :login
     else
      @store = Store.new
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @store }
      end
    end
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
       redirect_to :action => :login
     else
      @store = Store.new(params[:store])
      @store.user_id = @user.id
      @store.activate
    
      respond_to do |format|
        if @store.save
          format.html { redirect_to @store, notice: 'Store was successfully created.' }
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
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
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
    
end
