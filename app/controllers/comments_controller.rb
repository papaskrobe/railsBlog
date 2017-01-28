class CommentsController < ApplicationController

  before_action :admin_user, only: [:destroy, :update, :pending, :release]
  

  def create
    if (current_user && Post.where(id: params["comment"][:to_post]).first[:comments_on])
      @comment = current_user.comments.build(comment_params)
      @comment.user_id = current_user.id
      if !@comment.save
        flash[:danger] = "Comment unavailable, please try again" 
        redirect_to ("/posts/" + @comment.to_post.to_s)
      else
        redirect_to ("/posts/" + @comment.to_post.to_s + "\#comment-" + @comment.id.to_s) 
      end
    elsif (Post.where(id: params["comment"][:to_post]).first[:guest_comment])
      @comment = Comment.new
      @comment.user_id = nil
      @comment.content = params[:comment][:content] 
      @comment.response_to = params[:comment][:response_to]
      @comment.to_post = params[:comment][:to_post]
      if !@comment.save
        flash[:danger] = "Comment unavailable, please try again"
        redirect_to ("/posts/" + @comment.to_post.to_s)
      else
        redirect_to ("/posts/" + @comment.to_post.to_s + "\#comment-" + @comment.id.to_s)
      end
    else
      flash[:danger] = "Comment unavailable, please try again"
      redirect_to ("/posts/" + params["comment"][:to_post].to_s) 
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to :back
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment]) then
     redirect_to root_path
    else
      flash[:success] = "Update unavailable"
      redirect_to :back
    end
  end

  def pending
    @comment = Comment.where(user_id: nil)
  end

  def approved
    params["comments"].each do |key, value|
      if value == "Approved" then
        Comment.where(id: key).first.update(user_id: 0)
      elsif value == "Deleted" then
        Comment.where(id: key).first.destroy
      end 
    end
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :response_to, :to_post)
    end

end
