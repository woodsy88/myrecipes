class MembersController < ApplicationController
  def signup
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
  end
  
  private
  
  def member_params
    params.require(:member).permit(:membername, :email, :password, :password_confirmation)
  end
  
end