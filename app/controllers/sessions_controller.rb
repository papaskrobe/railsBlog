class SessionsController < ApplicationController

  def new
    request.referer ? session[:return_to] ||= request.referer : session[:return_to] ||= root_path 
    #session[:return_to] ||= request.referer
  end

#for above/below methods: either pair of requests (both of the commented/both of the not) seem to work.
#tweaked them when I tried to go direct to user page from illegal page (pending_approval) when not logged in.
#not sure if there is an advantage to one over the other.

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #redirect_to :back
      redirect_to session.delete(:return_to) 
      
    else
      flash.now[:alert] = 'The username or password could not be found'
      render 'new'
    end
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def destroy
    forget(current_user)
    log_out if logged_in?
    redirect_to :back 
  end

end
