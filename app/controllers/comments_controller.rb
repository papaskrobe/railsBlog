class CommentsController < ApplicationController


  def create
    if current_user
      @comment = current_user.comments.build(comment_params)
      @comment.user_id = current_user.id
      if !@comment.save
        flash[:danger] = "Comment unavailable, please try again" 
        redirect_to ("/posts/" + @comment.to_post.to_s)
      else 
        redirect_to ("/posts/" + @comment.to_post.to_s + "\#comment-" + @comment.id.to_s) 
      end
    elsif Post.where(id: comment_params.to_post)[0][:guest_comment] 
      @comment = Comment.new
      @comment.user_id = nil

    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :response_to, :to_post)
    end

end
