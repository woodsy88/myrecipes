class MembersController < ApplicationController
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
     #handle it
     flash[:success] = "Welcome #{@member.membername} to RinkTrader"
     redirect_to member_path(@member)
   else
     render 'new'
   end
  end
  
  def show
    @member = Member.find(params[:id])
    @member_tips = @member.tips.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @member = Member.find(params[:id])
  end
  
  def update 
    @member = Member.find(params[:id])
    
    if @member.update(member_params)
      flash[:success] = "Your account was updated succesfully"
      redirect_to @member
    else
      render 'edit'
    end
  end
  
  private
  
  def member_params
    params.require(:member).permit(:membername, :email, :password, :password_confirmation)
  end
  
end