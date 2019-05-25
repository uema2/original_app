class ClipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @hobby = Hobby.find(params[:hobby_id])
    current_user.like(@hobby)
    redirect_to @hobby
  end

  def destroy
    @hobby = Clip.find(params[:id]).hobby
    current_user.unlike(@hobby)
    redirect_to @hobby
  end
end
