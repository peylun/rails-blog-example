class UsersController < ApplicationController
  before_action :set_article, only: [:update, :destroy, :show, :edit]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome on board #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "User information was successfully updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "User was successfully deleted!"
    redirect_to users_path
  end
  
  def index
    @users = User.all
  end
  
  def edit
  end
  
  def show
  end
  
  private
    def set_article
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end