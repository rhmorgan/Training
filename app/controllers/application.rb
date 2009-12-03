# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  def login_required
    if session[:user]
      if session[:user].role_id == 1
        return true
      else
         redirect_to :controller => "setup", :action => "index"
         return true
      end
    end
    flash[:warning]='Please login to continue'
#    session[:return_to]=request.request_uri
    redirect_to :controller => "user", :action => "login"
    return false 
  end

  def admin_login_required
    if session[:user]
      if session[:user].role_id == 2
        return true
      else
         redirect_to :controller => "result", :action => "index"
         return true
      end
    end
    flash[:warning]='Please login to continue'
#    session[:return_to]=request.request_uri
    redirect_to :controller => "user", :action => "login"
    return false 
  end

  def current_user
    session[:user]
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to_url(return_to)
    else
      redirect_to :controller=>'user', :action=>'welcome'
    end
  end
end
