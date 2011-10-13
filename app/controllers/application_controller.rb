class ApplicationController < Spree::BaseController
   def is_iphone_request?
        request.user_agent =~ /(Mobile\/.+Safari)/
  end
  def is_android_request?
        request.user_agent =~ /(Mobile\/.+Safari)/
  end

end
