class HobbiesController < ApplicationController
  before_action :find_hobby, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @hobby = Hobby.all.order('updated_at DESC').page(params[:page]).per(12)
    
  end
  
  def show
    @user = @hobby.user
    
  end
  
  def new
    @hobby = current_user.hobbies.build
  end
  
  def create
    @hobby = current_user.hobbies.build(hobby_params)
    
    if @hobby.save
      flash[:success] = 'hobbyを作成しました。'
      redirect_to @hobby
    else
      
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @hobby.update(hobby_params)
      redirect_to @hobby
    else
      render :edit
    end
  end
  
  def destroy
    @hobby.destroy
    flash[:success] = 'hobbyを削除しました。'
    redirect_to user_path(current_user)
  end
  
  
  private
  
  def hobby_params
    params.require(:hobby).permit(:title, :content, :kind, :category)
  end
  
  def find_hobby
    @hobby = Hobby.find(params[:id])
  end
  
  def correct_user
    @hobby = current_user.hobbies.find_by(id: params[:id])
    unless @hobby
      redirect_to root_url
    end
  end
end
