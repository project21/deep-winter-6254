class ApplicationController < ActionController::Base
  protect_from_forgery
helper_method :admin?
 protected

def authorize
    unless admin?
      flash[:error] = "Unauthorized access"
      redirect_to :controller=>"products",:action=>"index"
      false
  else
  	redirect_to :controller=>"products",:action=>"new"
    end
  end

   def admin?
  session[:name] == "secret"
end

end
