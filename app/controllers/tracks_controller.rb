class TracksController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_track, only: %i(show edit update)

  def index
    @playlist = current_user.playlists.find(params[:playlist_id]) if params[:playlist_id]
    @tracks = current_user.tracks
  end

  def edit
  end

  def update
    if @track.update_attributes(track_params)
      redirect_to tracks_path
    else
      flash[:alert] = @track.errors.full_messages
      redirect_to edit_track_path(@track.id)
    end
  end

  private

  def track_params
    params.require(:track).permit(:track_number, :artist, :album, :title)
  end

  def fetch_track
    @track = current_user.tracks.find(params[:id])
  end
end
