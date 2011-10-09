class OwnersController < Spree::BaseController
  # GET /owners.json
  def index
    #@owners = Owner.all
    @owner = Owner.find_by_id(User.current.id)
      if @owner.nil?
          redirect_to :action => :new
      else
          redirect_to :action => :show , :id => User.current.id
      end
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
    @owner = Owner.find_by_id(User.current.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @owner }
    end
  end

  # GET /owners/new
  # GET /owners/new.json
  def new
    @owner = Owner.create( :user_id => User.current.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @owner }
    end
  end

  # GET /owners/1/edit
  def edit
    @owner = Owner.find(params[:id])
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(params[:owner])

    respond_to do |format|
      if @owner.save
        format.html { redirect_to @owner, notice: 'Owner was successfully created.' }
        format.json { render json: @owner, status: :created, location: @owner }
      else
        format.html { render action: "new" }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /owners/1
  # PUT /owners/1.json
  def update
    @owner = Owner.find(params[:id])

    respond_to do |format|
      if @owner.update_attributes(params[:owner])
        format.html { redirect_to @owner, notice: 'Owner was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy

    respond_to do |format|
      format.html { redirect_to owners_url }
      format.json { head :ok }
    end
  end
end
