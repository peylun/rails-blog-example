class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :show, :edit]
  before_action :require_same_user, only: [:update, :destroy, :edit]
  
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
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    def require_same_user
      if !logged_in? || current_user != @user
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end
end