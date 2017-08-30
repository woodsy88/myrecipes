class TipsController < ApplicationController
  before_action :set_tip, only: [:show, :edit, :update, :destroy]
  
  before_action :require_user, only: [:new, :edit, :update, :destroy]
  
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @tips = Tip.paginate(page: params[:page], per_page: 5)
  end
  
  def show
   #@tip = Tip.find(params[:id])
  end
  
  def new 
    @tip = Tip.new()
  end
  
  def create
    @tip = Tip.new(tip_params)
    @tip.member = current_member
    
    if @tip.save
      flash[:success] = "Tip was created Succesffuly"
      redirect_to tip_path(@tip)
    else
      render 'new'
    end
    
  end
  
  def edit
    #@tip = Tip.find(params[:id])
  end
  
  def update
    #@tip = Tip.find(params[:id])
    if @tip.update(tip_params)
      flash[:success] = "Recipe was updated succesfully"
      redirect_to tip_path(@tip)
    else
      render 'edit'
    end
  end
  
  def destroy
    Tip.find(params[:id]).destroy
    flash[:success] = "Tip deleted"
    redirect_to tips_path
  end
  
  private 
  
  def set_tip
    @tip = Tip.find(params[:id])
  end
  
  def tip_params
    params.require(:tip).permit(:name, :description)
  end
  
  def require_same_user
    if current_member != @tip.member and !current_member.admin?
      flash[:danger] = "You can only edit or delete your own tips"
      redirect_to tips_path 
    end
  end
  
end