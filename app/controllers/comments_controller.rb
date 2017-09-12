class CommentsController < ApplicationController
  before_action :require_user
  
  def create
      @tip = Tip.find(params[:tip_id])
      @comment = @tip.comments.build(comment_params)
      @comment.member = current_member
      
      if @comment.save
        flash[:success] = "Comment was saved succesfully"
        redirect_to tip_path(@tip)
      else
        flash[:danger] = "Comment was not created"
        redirect_to :back
      end
  end

private

  def comment_params
    params.require(:comment).permit(:description)
  end
  
end