class RelationshipsController < ApplicationController

  def create
    following = current_user.follow(params[:id])
    following.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    following = current_user.unfollow(params[:id])
    following.destroy
    redirect_back(fallback_location: root_path)
  end
end
