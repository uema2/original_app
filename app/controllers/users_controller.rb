class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.all.page(params[:page]).per(30).search(params)
    if @users.empty?
      flash.now[:danger] = '検索結果が得られませんでした。'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @hobby = @user.hobbies.order('updated_at DESC').page(params[:page]).per(12)
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
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
  
  def clips
    @user = User.find(params[:id])
    @clip_hobbies = @user.clip_hobbies.page(params[:page]).per(10)
    count(@user)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to (root_url) unless current_user?(@user)
  end
  
  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end
end
