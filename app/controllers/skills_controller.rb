class SkillsController < ApplicationController
  before_action :set_skill, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]
  
 
  
  def new
    @skill = Skill.new
  end
  
  def create 
    @skill = Skill.new(skill_params)
    if @skill.save
      flash[:success] = "Skill was created"
      redirect_to skill_path(@skill)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @skill.update(skill_params)
      flash[:success] = "Skill was updated"
      redirect_to @skill
    else
      render 'edit'
    end
  end
  
  def show
     @skill_tips = @skill.tips.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @skills = Skill.paginate(page: params[:page], per_page: 5)
  end
  
  private 
  
  def set_skill
    @skill = Skill.find(params[:id])
  end
  
  def skill_params
    params.require(:skill).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_member.admin?)
      flash[:danger] = "only admin users can perform that action"
      redirect_to skills_path
    end
  end
  
end