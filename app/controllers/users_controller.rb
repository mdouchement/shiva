class UsersController < ApplicationController
  include TracksIndexer
  before_action :authenticate_user!

  def me
  end

  def update
    if current_user.update_attributes(update_params)
      index_tracks(params[:user][:reindexing_path]) if params.key?(:reindexing_action)
      redirect_to root_path
    else
      flash[:alert] = current_user.errors.full_messages
      redirect_to me_users_path
    end
  end

  private

  def update_params
    params.require(:user).permit(:reindexing_path, :streaming_behavior)
  end
end
