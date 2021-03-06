class FriendshipsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end
  
  def index
    @friendshipOne = current_user.friendships
    @friendshipTwo = current_user.inverse_friendships
  end

  def destroy
    if params[:inverse] == 'false'
      @friendship = current_user.friendships.find(params[:id])
    else
      @friendship = current_user.inverse_friendships.find(params[:id])
    end
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end
  
end