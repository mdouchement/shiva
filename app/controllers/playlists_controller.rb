class PlaylistsController < ApplicationController
  include PlaylistTracksUpdater
  include PlaylistGenerator

  before_action :authenticate_user!
  before_action :fetch_playlist, only: %i(show edit update download destroy)

  def index
    @playlists = current_user.playlists
  end

  def show
    @tracks = @playlist.tracks
  end

  def edit
    @tracks = current_user.tracks
  end

  def update
    @playlist.assign_attributes(playlist_params)
    update_tracks(params[:playlist][:track])
    if @playlist.save
      redirect_to playlists_path
    else
      flash[:alert] = playlist.errors.full_messages
      redirect_to edit_playlist_path(@playlist.id)
    end
  end

  def new
    @playlist = Playlist.new
    @tracks = Track.all
  end

  def create
    @playlist = Playlist.new(playlist_params.merge(user: current_user, token: SecureRandom.hex))
    update_tracks(params[:playlist][:track])
    if @playlist.save
      redirect_to playlists_path
    else
      flash[:alert] = @playlist.errors.full_messages
      redirect_to new_playlist_path
    end
  end

  def download
    case params[:extension]
    when 'm3u8'
      send_data m3u8_playlist,
        filename: "#{@playlist.name}.m3u8",
        type: 'text/plain',
        disposition: 'attachment'
    when 'xspf'
      template = Tilt.new('app/views/playlists/download.xml.builder')
      send_data template.render(self),
        filename: "#{@playlist.name}.xspf",
        type: 'text/plain',
        disposition: 'attachment'
    end
  end

  def destroy
    @playlist.destroy!
    redirect_to playlists_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :token)
  end

  def fetch_playlist
    @playlist = current_user.playlists.find(params[:id])
  end
end
