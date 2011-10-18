class SurveyController < Spree::BaseController
  
  def show
        respond_to do |format|
         format.html # show.html.erb
       end
   end
   
   # POST /survey
   def create
      @interest = Interest.new(params[:item])
      respond_to do |format|
        if @interest.save
          format.html    { redirect_to root_path, notice: 'Thanks for your interest.' }
        else
          redirect_to root_path
        end
      end
    end
end
