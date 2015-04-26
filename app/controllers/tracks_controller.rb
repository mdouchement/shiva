class TracksController < ApplicationController
  def index
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
