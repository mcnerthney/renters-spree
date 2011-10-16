class ServeyController < Spree::BaseController
  
  def show
        respond_to do |format|
         format.html # show.html.erb
       end
   end
  
end
