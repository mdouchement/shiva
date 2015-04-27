class TracksController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlist = Playlist.find(params[:playlist_id]) if params[:playlist_id]
    @tracks = Track.all
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    track = Track.find(params[:id])
    if track.update_attributes(track_params)
      redirect_to tracks_path
    else
      flash[:alert] = track.errors.full_messages
      redirect_to edit_track_path(track.id)
    end
  end

  private

  def track_params
    params.require(:track).permit(:track_number, :artist, :album, :title)
  end
end
