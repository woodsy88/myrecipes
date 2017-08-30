class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #makes these methods available to our views
  helper_method :current_member, :logged_in?
  
  def current_member
    #checks to see if the member is logged in
    #if current member is there grab it right away or find the member and store it in @current_member
    @current_member ||= Member.find(session[:member_id]) if session[:member_id]
  end
  
  def logged_in?
    # turns expresion into evaluating true or false
    !!current_member 
  end
  
  def require_user
     # if not logged in
    if !logged_in?
      flash[:danger] = "you must be logged in to peform that action"
      redirect_to root_path
    end
  end
end
