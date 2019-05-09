class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @hobby = @user.hobbies.order('updated_at DESC').page(params[:page]).per(12)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age, :introduction)
  end

  def current_user?(user)
    user == current_user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to (root_url) unless current_user?(@user)
  end
end
