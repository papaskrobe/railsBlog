class CommentsController < ApplicationController


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

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :response_to, :to_post)
    end

end
