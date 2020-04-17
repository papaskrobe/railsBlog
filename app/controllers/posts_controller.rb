class PostsController < ApplicationController

  before_action :logged_in_user, only: :new
  before_action :writer_user, only: [:new, :edit, :create]

  def index
    redirect_to root_url
  end

  def show
    if Post.find_by(url: params[:id]) then 
      @post = Post.find_by(url: params[:id])
      @comment = Comment.new(to_post: @post.id)
    elsif @post = Post.find_by(id: params[:id])
      redirect_to ("/posts/" + @post.url)
      @comment = Comment.new(to_post: @post.id)
    else
      render file: "/public/404.html"   
    end
  end

  def new
    @post = Post.new
    render 'edit'
  end

  def create
    @post = Post.new(post_params)
    if params[:save]
      if @post.save
        redirect_to ("/edit/" + @post.id.to_s)
      else
        render 'edit'
      end
    else  
      @post.posted = Time.now
      if @post.save
        redirect_to @post 
      else
        render 'edit' 
      end
    end
  end

  def edit
      if !Post.find_by(id: params[:id])  then
        render 'choose'
      else
        @post = Post.find(params[:id])
      end
  end

  def update
    @post = Post.find(params[:id])

    if params[:save]
      if @post.update(post_params)
        redirect_to ("/edit/" + @post.id.to_s)
      end
    elsif params[:unpublish]
      if @post.posted == nil then
        @post.delete
        redirect_to root_url
      else
        @post.posted = nil
        if @post.update(post_params)
          redirect_to root_url
        end 
      end
    else
      if @post.posted == nil then
        @post.posted = Time.now
      end
      if @post.update(post_params) then
        redirect_to @post
      end
    end
  end     

  def page
    @posts_var = 4
    total_posts = Post.where.not(posted: nil).count
    
    if params[:id] == "1"
      redirect_to root_url
    elsif params[:id].to_i < 1 || (params[:id].to_i - 1) * @posts_var > total_posts 
      params[:id] = 1 
    end

    @page_posts = Post.where.not(posted: nil).order(posted: :desc).offset(((params[:id].to_i)- 1) * @posts_var).take(@posts_var)  

    @prev_page = true unless params[:id].to_i == 1
    @next_page = ((params[:id].to_i * @posts_var > total_posts) ? false : true)

  end

  def archive
    @posts = Post.where.not(posted: nil).order(posted: :desc)
  end

  private
    
    def post_params
      params.require(:post).permit(:title, :url, :content_final, :posted, :guest_comment, :comments_on)
    end

    def correct_user(post)
      (current_user && (current_user.status_admin? || post.user_id == current_user[:id]))
    end
end
