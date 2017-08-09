class TipsController < ApplicationController
  before_action :set_tip, only: [:show, :edit, :update]
  
  def index
    @tips = Tip.all
  end
  
  def show
   #@tip = Tip.find(params[:id])
  end
  
  def new 
    @tip = Tip.new()
  end
  
  def create
    @tip = Tip.new(tip_params)
    @tip.member = Member.first
    
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
  
end