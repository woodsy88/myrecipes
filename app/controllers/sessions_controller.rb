class SessionsController < ApplicationController
  
  def new 
    
  end
  
  def create
    #find the member
    member = Member.find_by(email: params[:session][:email].downcase)
    if member && member.authenticate(params[:session][:password])
      session[:member_id] = member.id     
      flash[:success] = "You have succesfully logged in"
      redirect_to member
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
      
  end

  def destroy 
    session[:member_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
  
end