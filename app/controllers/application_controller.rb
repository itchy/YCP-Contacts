class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

private  
  def current_user
    @current_user ||= User.find(session[:user_id])
    rescue
      nil
  end
  
  def set_current_user(user)
    if user && user.respond_to?(:id)
      @current_user = user
      session[:user_id] = @current_user.id
    else
      @current_user = nil
      session[:user_id] = nil
    end    
  end
  
  def authenticate
    if current_user
      session[:user_id] = current_user.id
      current_user.id
    else
      exit
    end    
  end
  
  def exit
    set_current_user(nil)
    redirect_to "/"
  end
  
  def admin_only
    unless current_user.admin?
      flash[:notice] = "You must be an admin to preform this action!"
      redirect_to profiles_path 
      return 
    end  
  end
  
  #SSJ Thsi is just a helper method used in development
  def identify
    fail "Controller => #{params[:controller]} Action => #{params[:action]}\nParams => #{params.inspect}"
  end
end
