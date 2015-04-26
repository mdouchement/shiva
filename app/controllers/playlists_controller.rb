class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    playlist = Playlist.find(params[:id])
    if playlist.update_attributes(playlist_params)
      redirect_to playlists_path
    else
      flash[:alert] = playlist.errors.full_messages
      redirect_to edit_playlist_path(playlist.id)
    end
  end

  def new
    @playlist = Playlist.new
  end

  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      redirect_to playlists_path
    else
      flash[:alert] = playlist.errors.full_messages
      redirect_to new_playlist_path
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
