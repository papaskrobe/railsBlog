class CommentsController < ApplicationController

  before_action :moderator_user, only: [:pending, :destroy] 

  def create
    if (current_user && Post.where(id: params["comment"][:to_post]).first[:comments_on])
      @comment = current_user.comments.build(comment_params)
      @comment.user_id = current_user.id
      @comment.ip_address = request.remote_ip
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
      @comment.ip_address = request.remote_ip
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

  def show
    redirect_to ("/posts/" + Comment.find(params[:id]).to_post.to_s + "#comment-" + params[:id])
  end


  def destroy
    response = Comment.where(id: params[:id]).first[:response_to]
    Comment.where(response_to: params[:id]).each { |x| x.update_attribute(:response_to, response) }
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to :back
  end

  def edit
    @comment = Comment.find(params[:id])
    redirect_to(root_url) unless correct_user(@comment)
  end

  def update
    @comment = Comment.find(params[:id])
    if (correct_user(@comment) && @comment.update(comment_params)) then
     redirect_to @comment 
    else
      flash[:success] = "Update unavailable"
      redirect_to :back
    end
  end

  def pending
    @comment = Comment.where(user_id: nil)
  end

  def approved
    if params["comments"] then
      params["comments"].each do |key, value|
        if value == "Approved" then
          Comment.where(id: key).first.update(user_id: 0)
        elsif value == "Deleted" then
          Comment.where(id: key).first.destroy
        end 
      end
    end
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :response_to, :to_post)
    end

    def correct_user(comment)
      (current_user && ((current_user.status_admin? || current_user.status_moderator?) || comment.user_id == current_user[:id])) 
    end 

    def moderator_user
      redirect_to(root_url) unless current_user.status_moderator?
    end 
end
