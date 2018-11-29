class RoomsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:create, :show, :index, :edit, :update, :destroy]
  
  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
    flash[:notice] = "チャットを作成しました！"
  end
  
  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_to "/rooms/#{@room.id}"
      flash[:alert] = "無効なユーザー"
    end
  end
  
  def index
    @entries = current_user.entries
  end
  
  def edit
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
    else
      flash[:alert] = "無効なユーザー"
      redirect_to "/rooms/#{@room.id}"
    end
  end
  
  def update
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user, :room_id => @room.id).present?
      @room.update(params.require(:room).permit(:name, :explain))
      flash[:notice] = "チャット情報が変更されました"
      redirect_to "/rooms/#{@room.id}/edit"
    else
      flash[:alert] = "無効なユーザー"
      redirect_to "/rooms/#{@room.id}"
    end
  end
  
  def destroy
    logger.debug("============================------------------ destrroy #{params[:id]}")
    @room = Room.find(params[:id])
    @room.delete
    redirect_to "/users/#{current_user.id}"
  end
end
