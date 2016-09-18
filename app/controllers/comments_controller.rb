class CommentsController < ApplicationController


  def create
    if current_user
      @comment = current_user.comments.build(comment_params)
      @comment.user_id = current_user.id
    elsif Post.where(id: comment_params.to_post)[0][:guest_comment] 
      @comment = Comment.new
      @comment.user_id = nil
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :response_to, :to_post)
    end

end
