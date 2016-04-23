class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end

  end

  def update
    @user = User.find(params[:id])
    @user.update_columns(user_update_params)
    redirect_to @user
  end

  private

    def user_create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:email, :status_commentor, :status_moderator, :status_writer, :signature) 
    end
end
