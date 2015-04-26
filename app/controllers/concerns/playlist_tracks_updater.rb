module PlaylistTracksUpdater
  extend ActiveSupport::Concern

  def update_tracks(track)
    track.each do |k, v|
      current_track = Track.find(k)
      if v == '1'
        @playlist.tracks << current_track unless @playlist.tracks.include?(current_track)
      else
        @playlist.tracks.delete(current_track)
      end
    end
  end
end
