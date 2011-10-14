class UserSessionsController < Devise::SessionsController
  include SpreeBase
  helper :users, 'spree/base'
  respond_to :html, :android
  
  before_filter :set_android_format

  include Spree::CurrentOrder

  after_filter :associate_user, :only => :create

  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar

  # GET /resource/sign_in
  def new
    super
  end

  def create
    authenticate_user!

    if user_signed_in?
      respond_to do |format|
        format.android {
          flash[:notice] = I18n.t("logged_in_succesfully")
          redirect_back_or_default(rents_path)
        }
        format.html {
          flash[:notice] = I18n.t("logged_in_succesfully")
          redirect_back_or_default(rents_path)
        }
        format.js {
          user = resource.record
          render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
        }
      end
    else
      flash[:error] = I18n.t("devise.failure.invalid")
      render :new
    end
  end

  def destroy
    session.clear

    if is_android_request?
      redirect_to rents_path
      return
    end
      
    super

  end

  def nav_bar
    render :partial => "shared/nav_bar"
  end

  private

  def associate_user
    return unless current_user and current_order
    current_order.associate_user!(current_user)
    session[:guest_token] = nil
  end

  def accurate_title
    I18n.t(:log_in)
  end


  def set_android_format
      if is_android_request?
        request.format = :android
      end
  end
    
  def is_android_request?
      request.user_agent =~ /.*Linux.*Android.*/
  end


end
