class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(comment_id: params[:comment_id])
    favorite.save
    redirect_to :back
  end

  def destroy
    favorite = Favorite.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    favorite.destroy
    redirect_to :back
  end
end
