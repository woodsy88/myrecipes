class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  
  def signup
  end
  
  def index
    @members = Member.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @member = Member.new
  end
  
  def create
   @member = Member.new(member_params)
   if @member.save
     session[:member_id] = @member.id
     #handle it
     flash[:success] = "Welcome #{@member.membername} to RinkTrader"
     redirect_to member_path(@member)
   else
     render 'new'
   end
  end
  
  def show
    #@member = Member.find(params[:id])
    @member_tips = @member.tips.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    #@member = Member.find(params[:id])
  end
  
  def update 
    #@member = Member.find(params[:id])
    
    if @member.update(member_params)
      flash[:success] = "Your account was updated succesfully"
      redirect_to @member
    else
      render 'edit'
    end
  end
  
  def destroy
   # @member = Member.find(params[:id])
    @member.destroy
    flash[:danger] = "Member has been deleted with all tips"
    redirect_to members_path
  end
  
  private
  
  def set_member
    @member = Member.find(params[:id])
  end
  
  def member_params
    params.require(:member).permit(:membername, :email, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_member != @member and !current_member.admin?
      flash[:danger] = "You can only delete your own account"
      redirect_to members_path
    end
  end
  
  def require_admin
    if logged_in? && !current_member.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
  
end