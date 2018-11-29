class UsersController < ApplicationController
  
  before_action :authenticate_user!, :only => [:show, :index, :edit, :update]

  def show
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @entries = current_user.entries.limit(3)
      logger.debug("==============------------------ room  あり")
    else
      logger.debug("==============------------------ no room ")
      @room = Room.new
      @entry = Entry.new
    end
  end
  
  def index
    @users = User.all
  end
  
  def edit
  @user = User.find(params[:id])
    if @user.id == current_user.id
    else
      redirect_to "/"
      flash[:alert] = "無効なユーザー"
    end
  end
  
  def update
  @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(params.require(:user).permit(:first_name, :family_name, :self_introduction, :age, :image))
      redirect_to "/users/#{@user.id}/edit"
      flash[:notice] = "編集が完了しました"
    else
      redirect_to "/"
      flash[:alert] = "無効なユーザー"
    end
  end


end
